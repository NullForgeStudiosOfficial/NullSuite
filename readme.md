# What is NullSuite?

NullSuite is a collection of Linux tools that absolutely did **not** start out as a collection of Linux tools.

# TL;DR

I got annoyed. So I made a button for it

Repeat 19 fuckin times.

---

## Why It Exists

It started because Windows 11 happened.

A bunch of my friends and family started looking at Linux as an alternative, Mint specifically, because I was the IT guy, and I've been using it for 2+ years now,  and naturally we all started running into the same thing:

Little problems.

Missing features.

Workflows that were easy on Windows but awkward on Linux.

Sometimes it was them discovering the problem first.

Sometimes it was me.


Usually the conversation went something like:

"Man, Linux really should have a better way to do this."

Followed shortly by:

"Yeah... why doesn't it?"

And then I'd disappear for a few hours...

---

## Inception

One of the first problems was audio.

Back on Windows I used VoiceMeeter constantly for streaming and audio management. Linux didn't really have a simple equivalent that worked the way I wanted.

So I did what any reasonable person would do.

I complained about it.

Then I got annoyed enough to write a script that fixed it.

Problem solved....

For about five days.

Then one of my friends wanted to move to Linux and immediately ran into the exact same problem.

"Hey, how do I set up that audio thing you made?"

At which point I discovered a terrible truth:

I couldn't explain my own script.

It worked perfectly.

I had no idea how to explain the seventeen terminal commands, PipeWire routing, package dependencies, and configuration nonsense required to use it.

And if I couldn't explain it, nobody else was going to use it.

So I said:

"Alright. Screw this."

And spent the next few days building a proper UI. With that 1995 lookin ass, Tkinter!

---

## Por que no los dos?

That project became NullWire.

Then I looked at the pile of other scripts I had scattered around my system and thought:

"What if I just turned all of these into actual tools too?"

I figured it would take a couple weeks.

It took six days. The code base was already there.

Turns out most of the hard part had already been done years earlier. I just kept giving my scripts buttons. Combining it all into one 12k long line script was the hard part.

That was the beginning of NullSuite.

Since then the process has remained remarkably consistent:

Someone has a problem.

Usually me.

Sometimes my spouses.

Sometimes a friend.

Sometimes a random Linux annoyance that has existed for fifteen years and nobody bothered fixing.

I get annoyed.

I write a solution.

The solution gets integrated into NullSuite.

Repeat.

Many times.

Very, very many times.

---

## Swiss Army Knife

NullSuite currently contains tools for audio routing, monitor management, MIDI devices, Proton launching, disc ripping, time tracking, emoji handling, Git integration, and whatever other nonsense I happened to build because something irritated me enough.

The goal isn't to make the prettiest software on Earth.

The goal is simple:

Make Linux easier to use.

Especially for people coming from Windows.

Will the UI look modern? Absolutely not. 

I like lightweight software.

I don't need Electron eating half a gigabyte of RAM just to show me three buttons and a toggle.



Will it look like something from 1998? Yes.

Will it solve the problem? That's the part I care about... and do it easily for people who have no idea how linux works.

Welcome to NullSuite.

At the moment it DOES require X11. If you have no idea what that is... Don't worry about it. 

When Wayland gets its head out of it's ass, and speeds up to modernity and takes over, yeah i'll have to re-do some stuff, but it aint that time yet. 

---

## Other Distros

NullSuite is developed on Linux Mint.

My machines run Linux Mint.

My spouses run Linux Mint.

Most of my friends run Linux Mint.


So that's what gets tested.

Will it work on other distros?

Maybe...Probably...No promises.


If you're running Arch, CachyOS, Gentoo, TempleOS, or some other Linux flavor created during a caffeine-fueled weekend project, you're officially in "here be dragons" territory.

I'm not going to stop you from trying it.

I'm just not going to guarantee anything.

And I won't be responsible for any bugs or issues that happen outside of Linux Mint.


Some tools rely on permissions, X11 behavior, PipeWire behavior, and other system quirks that aren't always consistent across distributions.

Wayland in particular is a frequent source of issues because it intentionally restricts access to things some of these tools need.

So if you're not on Linux Mint:

Good luck.

May the odds be ever in your favor.

---

## Programs. 

Holy shit there is a lot of them. I'm sorry.

### [NullWire](ProgramInfo/NullWire/NullWire.md) — Crackhead's Virtual Audio Cable/VoiceMeeter. Made for streaming. Then it escaped containment.

### [NullMonitor](ProgramInfo/NullMonitor/NullMonitor.md) — Monitor Setups, Cursor Teleporting, Wallpaper Manager... I'm tired.

### [NullMidi](ProgramInfo/NullMidi/NullMidi.md) — Started because I wanted CloneHero drums... WITH SOUNDS! Ended with custom hardware, soldering, virtual MIDI devices, and an identity crisis. Send help.

### [NullProton](ProgramInfo/NullProton/NullProton.md) — Want Proton without Steam? You're asking "why". I'm saying..."why not". Also a Linux launcher for the 3 games that run natively on Linux!

### [NullRip](ProgramInfo/NullRip/NullRip.md) — DVD In. Video Out. Simple as. I couldn't be fucked remembering 18000 HandBrakeCLI commands, and I have a Jellyfin to fill. (Blu-ray support coming when I get a god damn Blu-ray drive. I learned soldering for NullMidi. This won't stop me forever.)

### [NullTracker](ProgramInfo/NullTracker/NullTracker.md) — Corporate Micromanagement, But For Yourself... Ok It's mostly to track myself(work stuff), but it could be useful for you too!

### [NullMoji](ProgramInfo/NullMoji/NullMoji.md) — Linux Didn't Have An Emoji Picker. So I Made One. With blackjack, and hookers!

### [NullGit](ProgramInfo/NullGit/NullGit.md) — Because "git add . && git commit -m" Gets Old Fast. Also. Checks if you're outdated. Handy. Use it for this repo lmao.


