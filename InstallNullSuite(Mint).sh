#!/bin/bash

# =================================
# NullSuite Installer
# =================================

BASE_DIR="$(dirname "$(realpath "$0")")"
RUNTIME_DIR="$BASE_DIR/Runtime"
DEPENDENCY_FILE="$RUNTIME_DIR/Dependencies.json"

cd "$BASE_DIR" || exit 1

echo ""
echo "================================="
echo "NullSuite Installer"
echo "================================="
echo ""

# =================================
# Functions
# =================================

Fail() {

    echo ""
    echo "================================="
    echo "INSTALL FAILED"
    echo "================================="
    echo "$1"
    echo ""

    read -rp "Press enter to exit..."
    exit 1
}

CheckCommand() {
    command -v "$1" >/dev/null 2>&1
}

VerifyImport() {

    local MODULE="$1"

    python3 - <<EOF || \
        Fail "Python import failed: $MODULE"
import $MODULE
EOF
}

# =================================
# Bootstrap
# =================================

BOOTSTRAP_PACKAGES=()

CheckCommand python3 || \
    BOOTSTRAP_PACKAGES+=("python3")

CheckCommand jq || \
    BOOTSTRAP_PACKAGES+=("jq")

if [ ${#BOOTSTRAP_PACKAGES[@]} -ne 0 ]; then

    echo ""
    echo "Installing bootstrap packages..."
    echo ""

    sudo apt update || \
        Fail "apt update failed."

    sudo apt install -y \
        "${BOOTSTRAP_PACKAGES[@]}" || \
        Fail "Failed installing bootstrap packages."

fi

# =================================
# Verify Files
# =================================

[ -d "$RUNTIME_DIR" ] || \
    Fail "Runtime directory missing."

[ -f "$DEPENDENCY_FILE" ] || \
    Fail "Dependencies.json missing."

# =================================
# Build Apt Package List
# =================================

APT_PACKAGES=()

while IFS="=" read -r Command Package
do

    CheckCommand "$Command" || \
        APT_PACKAGES+=("$Package")

done < <(
    jq -r '
        .Commands
        | to_entries[]
        | "\(.key)=\(.value)"
    ' "$DEPENDENCY_FILE"
)

# =================================
# tkinter
# =================================

python3 - <<EOF 2>/dev/null || \
    APT_PACKAGES+=("python3-tk")
import tkinter
EOF

# =================================
# AppIndicator
# =================================

python3 - <<EOF 2>/dev/null || \
    APT_PACKAGES+=("python3-gi" "gir1.2-appindicator3-0.1")
import gi
gi.require_version("AppIndicator3", "0.1")
EOF

# =================================
# Python Dev Package
# =================================

PYTHON_VERSION=$(python3 -c \
"import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

PYTHON_DEV_PACKAGE="python${PYTHON_VERSION}-dev"

dpkg -s "$PYTHON_DEV_PACKAGE" >/dev/null 2>&1 || \
    APT_PACKAGES+=("$PYTHON_DEV_PACKAGE")

# =================================
# Venv Support
# =================================

TEMP_VENV="/tmp/nullsuite_venv_test"

rm -rf "$TEMP_VENV"

if ! python3 -m venv "$TEMP_VENV" >/dev/null 2>&1; then

    APT_PACKAGES+=("python${PYTHON_VERSION}-venv")

fi

rm -rf "$TEMP_VENV"

# =================================
# Remove Duplicates
# =================================

APT_PACKAGES=(
$(printf "%s\n" "${APT_PACKAGES[@]}" | sort -u)
)

# =================================
# Install Apt Packages
# =================================

if [ ${#APT_PACKAGES[@]} -ne 0 ]; then

    echo ""
    echo "Installing required packages:"
    echo ""

    printf ' - %s\n' "${APT_PACKAGES[@]}"

    echo ""

    sudo apt update || \
        Fail "apt update failed."

    sudo apt install -y \
        "${APT_PACKAGES[@]}" || \
        Fail "Failed installing required packages."
fi

# =================================
# Verify Commands
# =================================

while IFS="=" read -r Command Package
do

    CheckCommand "$Command" || \
        Fail "Command missing after install: $Command"

done < <(
    jq -r '
        .Commands
        | to_entries[]
        | "\(.key)=\(.value)"
    ' "$DEPENDENCY_FILE"
)

# =================================
# Verify tkinter
# =================================

VerifyImport tkinter

# =================================
# Verify AppIndicator
# =================================

python3 - <<EOF || \
    Fail "AppIndicator verification failed."

import gi
gi.require_version("AppIndicator3", "0.1")

EOF

# =================================
# GNOME Tray Support
# =================================

DE="${XDG_CURRENT_DESKTOP:-}"

if [[ "$DE" == *"GNOME"* ]]; then

    echo ""
    echo "GNOME detected."

    if grep -qi ubuntu /etc/os-release; then

        sudo apt install -y \
            gnome-shell-extension-appindicator || \
            Fail "Failed installing GNOME tray extension."
    fi
fi

# =================================
# Runtime Directory
# =================================

cd "$RUNTIME_DIR" || \
    Fail "Failed entering Runtime directory."

# =================================
# Create Venv
# =================================

if [ ! -d "venv" ]; then

    echo ""
    echo "Creating virtual environment..."

    python3 -m venv \
        venv \
        --system-site-packages || \
        Fail "Failed creating virtual environment."
fi

if [ ! -f "venv/bin/activate" ]; then

    Fail "Virtual environment activation script missing."

fi

source venv/bin/activate || \
    Fail "Failed activating virtual environment."

# =================================
# Upgrade Pip
# =================================

echo ""
echo "Upgrading pip..."

python3 -m pip install --upgrade pip || \
    Fail "Failed upgrading pip."

# =================================
# Find Missing Python Packages
# =================================

MISSING_PYTHON_PACKAGES=()

while IFS="=" read -r Module Package
do

    python3 - <<EOF >/dev/null 2>&1
import $Module
EOF

    if [ $? -ne 0 ]; then

        MISSING_PYTHON_PACKAGES+=("$Package")

    fi

done < <(
    jq -r '
        .Modules
        | to_entries[]
        | "\(.key)=\(.value)"
    ' "$DEPENDENCY_FILE"
)

# =================================
# Remove Duplicates
# =================================

MISSING_PYTHON_PACKAGES=(
$(printf "%s\n" "${MISSING_PYTHON_PACKAGES[@]}" | sort -u)
)

# =================================
# Install Missing Python Packages
# =================================

if [ ${#MISSING_PYTHON_PACKAGES[@]} -ne 0 ]; then

    echo ""
    echo "Installing Python dependencies..."
    echo ""

    printf ' - %s\n' "${MISSING_PYTHON_PACKAGES[@]}"

    echo ""

    python3 -m pip install \
        "${MISSING_PYTHON_PACKAGES[@]}" || \
        Fail "Failed installing Python dependencies."

fi

# =================================
# Verify Python Imports
# =================================

while read -r Module
do

    VerifyImport "$Module"

done < <(
    jq -r '
        .Modules
        | keys[]
    ' "$DEPENDENCY_FILE"
)

deactivate

# =================================
# Runtime Script Permissions
# =================================

chmod +x "$RUNTIME_DIR"/*.sh \
    2>/dev/null || true

# =================================
# Desktop Entries
# =================================

mkdir -p "$HOME/.local/share/applications"

DESKTOP_FILE="$HOME/.local/share/applications/nullsuite.desktop"

FULL_PATH="$(realpath "$RUNTIME_DIR/NSLauncher.sh")"

ICON_PATH="$(realpath \
"$RUNTIME_DIR/NullSuite.png" \
2>/dev/null || true)"

echo ""
echo "Creating desktop entry..."

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=NullSuite
Exec=$FULL_PATH
Icon=$ICON_PATH
Type=Application
Terminal=false
Categories=Utility;
EOF

chmod +x "$DESKTOP_FILE"

# =================================
# NullZip Desktop Entry
# =================================

NULLZIP_DESKTOP="$HOME/.local/share/applications/NullZip.desktop"

NULLZIP_PATH="$(realpath "$RUNTIME_DIR/NullZip.sh")"

cat > "$NULLZIP_DESKTOP" <<EOF
[Desktop Entry]
Name=NullZip
Exec=$NULLZIP_PATH %f
Type=Application
Icon=$ICON_PATH
MimeType=application/zip;application/x-rar;application/x-7z-compressed;application/x-tar;application/gzip;application/x-bzip2;
Terminal=true
NoDisplay=true
EOF

chmod +x "$NULLZIP_DESKTOP"

update-desktop-database \
"$HOME/.local/share/applications" \
>/dev/null 2>&1 || true

# =================================
# Tracker Logs
# =================================

mkdir -p "$RUNTIME_DIR/TrackerLogs"

# =================================
# NullMidi Permissions
# =================================

echo ""
echo "Configuring NullMidi permissions..."

echo "$USER ALL=(ALL) NOPASSWD: /bin/chmod 666 /dev/uinput" | \
sudo tee /etc/sudoers.d/nullsuite-uinput >/dev/null || \
Fail "Failed configuring NullMidi permissions."

sudo chmod 440 \
/etc/sudoers.d/nullsuite-uinput

# =================================
# Complete
# =================================

echo ""
echo "================================="
echo "NullSuite Installed Successfully"
echo "================================="
echo ""

echo "Launch NullSuite from your applications menu."

echo ""

read -rp "Press enter to exit..."