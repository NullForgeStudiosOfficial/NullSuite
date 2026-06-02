# NullMonitor
---

Or formally known as NullCursor if you're in the know.

Look. 
This started out as my friend complaining to me "Hey i can't move my mouse from my 4k monitor to my 1080p monitor? Windows does that natively. so what gives"

Unacceptable. I must fix this

So thus it begins...

## What Can It Do?

Makes your Cursor heccin TELEPORT BRO. MAGIC n shit.

Ok not really it just says "Hey your mouse is at the edge of the screen...and dumbo tryna keep movin....put it in the top(←/→) corner of the adjacent monitor 👍".

Least that was version 0.0.0.0.1

Now you can set up your OWN warps. (it's easy trust me)


AND

You can keep monitor profiles(This one was for me)

When at my desk i use my 3 monitors, but when at my drumset i got a monitor over by it, and yeah. didn't wanna fuckin open display settings every time i wanna play drums. so. 

CLICKY SQUARE and it switches. EZPZ (windows don't even have that >.>)



and now due to my wife. Wallpaper management!

I set her up with HydraPaper, but she couldn't find it/remember the name(which...fair). OR get it to do what she wanted so... I made my own. yaknow. with blackjack. and hookers. 

AND attached it into my monitor profile setup's 🤨 infrastructure was already there. so. WHY NOT!?

But, do YOU have a weird as hell monitor setup, and doing mulitple monitor wallpapers is a pain in the ass? 

Well it still is :D just less so!


Now...how the hell do you do all this...


# How To Use
---

## Cursor Warps

👏 Alright homie(Yes were homies, you're fuckin reading this aren't you?)

I've added tooltips to NullMonitor cause...shits confusing sometimes.

First Things first. When you first checkmark NullMonitor on the mainmenu of NullSuite....It creates a profile for you. Called Default.

It basically captures your current monitor layout and everything, and saves it. If its wrong? well..we'll get there. 

ANYWAYS. there is a box there. "Scan For Mouse" This is left OFF by default. 

Because every so often the system will scan for your cursor position... This isn't too resource intensive, buuuuuut it uses enough to the point that i'd rather it be disabled by default. were talking 0.15% on most computers, when NullSuite usually uses 0.07% ish. So. It's noticable.

ANNNNNNYWAYS Click that mf box. 

Hover your mouse over that "Detection" text. Tells you what's up. 

If you hover over the slider bar. It will show you in red when the mouse detection goes into maximum overdrive (doesn't use more resources, it just.. "wakes up", ignores your cursor otherwise)

Play around with that till it feels nice for you. 

Next. if you hover over the "Buffer" text. it will tell you what the Buffer is for. Basically when the cursor is awake and enters the buffer zone... warps work. 

Buffer is set in pixels. and yes hovering over the number will show you how much that is.

aaaand finally Scantime? Thats how often the system scans for your mouse entirely while scan for mouse is alive. 

A lower value means warps happen faster, but uses more resources, a higher value means warps happen slower, take longer to register, but uses less resources. (i mean it hardly uses any resources at all, but i'd rather you have the option than not)


SO lets set up a damn warp. Let's assume you just have one monitor. Peasent. 

(...HOLY SHIT wait. ^ so i typed that line, and im like...wait. you can't do NullMonitor with single monitors, and im like "well thats a problem" — I'll explain the tutorial and THEN the issue, and fix.)

You click create warp. A black box in the corner of your monitor appears, and a popup appears saying "Selec where you're warping FROM" e.g. → going from this monitor.

Once you do that both, popups disappear(This is the issue I noticed). A new one appears "Select where you're warping TO" e.g. ← going TO this monitor. 

Then another popup appears. Choose the warp points. Typically I choose "Top Left" on (From), and "Top Right" on (To).

Hit add. And now when scanning for mouse. If you go to the top left of Monitor 1, It will now appear in the top right of monitor 2. Handy if you don't have all monitors of the same resolution.


— Now that the tutorial is over. UH. i went into the code, and commented out the part that makes the blackbox on the monitor disappear. So NOW. if you just have a huge ass ultrawide monitor? 

You can just select the same monitor twice. Select left side on "From" and selet Right side on "To" and now going left on the ultra wide will make you appear on the right of the ultrawide.

I don't even have a ultrawide. I can't use this. But the problem is... If you tried to do this in a single monitor. The popup would go away...it would just soft lock you cause you can't pick a second. 

So I turned a bug into a feature. YAY

*AHEM*

## Monitor Profiles
---

Lets get this setup. its EASY. 

See how your monitors are set up in that goofy ass way? You live like this? Great. Not my problem.

Go ahead in that NullMonitor InputField and type out a name for it. You hit Add? It saves everything. 
• What monitors are currently on
• Where they're connected (e.g display port 1)
• WHERE they are in X/Y Cordinates relative to how you set it up in Display Settings.
• The Refresh Rates
• The Resolutions

.. Yeah thats it. It just creates a snapshot/copy of how your monitors are setup at the current time you click on that big ol "add" button. Congrats.  You made a monitor profile. 

The TRICK is. 

Whenever you click on the "Active" box on a monitor profile? I switches everything to that snapshot. So yes... It will rearrange/turn off/turn on/set positions/set refresh rate all that...in a single click.

and Yes...You can have duplicate profiles... Why?

Becauuuuuse:

## WallPaper Manager
---

ALSO easy.  After creating a profile (or just using the default) Checkbox that damn "Wallpapers" toggle.... voila. BUTTON APPEARS. 

Click that button. aand you're whisked away to a fairy tale land where you can....see a mock up of your monitor setup because honestly why do you need more?

NOW... Browse for an image.... Set the thing...and then with the dropdown to the right. Set how you want the image to look...NOW

Uploading a image? Changes your desktop background. 

Switching any Dropdown? Changes your desktop background. 

If any is blank? It generates a black area for you.

That's it...

Now onto why we allow Duplicate Profiles for monitor setups. 

Well 1, because I'm stupid  and didn't add a block for it, becuase I didn't think anyone would ever do that. 

And 2, ... well with wallpaper setup. you can have the same monitor setup, but you can create different wallpaper configurations. 

Have your basic default wallpaper setup? Sure. 

OH its halloween and you want spoopy? COOL. switch to your (Default:Halloween)  or w/e you named it. Bam. Now you have halloween wallpapers in your default monitor setup. 

NIFTY.

## Conclusion
---

IDK what else to say about it so...

Some statements...

No I won't be adding support for animated wallpapers, or slide show wallpapers.

... Or if I do. Realize there is NO way to do it efficiently. (that I know of)

Linux Mint Desktop Compositor is a chonky beast. Just setting up wallpapers on multiple monitors uses about 3% of my CPU for a split second. Imagine every millisecond for animation 🤨 you would make a CPU based space heater

Actually... that sounds hilarious. 

Animating a fire wallpaper on your computer, and your CPU is putting out actual heat because of it. 

... I might do that for the fucking lols now. 

but no i got too much to do as it is...

TOODLES 




