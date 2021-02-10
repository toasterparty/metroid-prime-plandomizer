# Metroid Prime Plandomizer

This is a collection of tools needed to make and play plandos for Metroid Prime. What is a plando you ask? It's a portemanteau of "planned" and "randomizer", or a non-vanilla item/elevator/door configuration to be played through using sequence-breaks. It's also technically an oxymoron.

Designing seeds instead of using randomly chosen ones allows for finely tuned difficulty, reduces back-tracking and can often provide gameplay experiences you wouldn't ever encounter in a logic-based randomizer. As people make plandos, I'll add them to the repository under the `/plandos` directory.

I didn't implement any of the ISO patching aspects of this project (you can thank Syncathetic and Yonic for that). I just made all the tools play nicely together and proved it works.

# Features
- Settable items/locations
- Settable elevator desitnations
- Settable door colors
- All the randomizer bells and whistles you're used to (frigate skip, item pickup message skip, 0-12 required artifacts etc...)

# How to Play a Plando
1. Go to the "releases" tab on the right and download the latest version for your platform and extract the contents onto your PC.
2. Copy your unmodified Metroid Prime ROM into the root directory and name it `prime.iso`.
3. Copy the `world_layout.json` file of the plando you wish to play into the root directory.
4. Run `plandomizer.exe` (just `plandomizer` on linux) and wait for patching to complete.
5. Load `prime_out.iso` into Dolphin or your Wii. You are ready to play!

# How to Make a Plando
1. Make a copy of `/plandos/_template/world_layout.json` and open in a text editor. This file contains a preset for all vanilla item locations, elevator destinations and door colors.
2. Set your patch settings as desired by changing the options to either `true` or `false`
3. Under `"excluded_doors"`, you will see all of the rooms names in the games. Set each door's colors in each room as desired by changing each of the options to any of the following:
- `"blue"` - Any Beam
- `"purple"` - Wave Beam
- `"white"` - Ice Beam
- `"red"` - Plasma Beam
- `"default"` - The door will be unpatched (remain vanilla color for that location)
- `"random"` - The door's color will be randomly chosen using the provided `"seed"` value and the provided `"weights"`.

Note that doors are represented as an array of door for each room starting with index 0, 1, 2 etc... To figure out what index in the room array a specific door is, use the map provided with [mpdr here](https://github.com/YonicDev/mpdr/releases).

4. Set the item layout, elevator layout and starting room by providing a custom `"layout_string"`. The best way to make a layout string is using [Syncathetic's web tool](https://aprilwade.github.io/randomprime/editor.html). Note that you can paste in an existing layout string to parse and edit it, as opposed to having to start from scratch each time you open the web page.

# Build

**NOTE:** *You don't need to do any of the below if you just want to make and play plandos.*

This repo uses a makefile to abstract some simple shell commands. The only thing that need to be built is the `randomprime` submodule. Under the hood, it's just installing rust and using `cargo build`.

You can try:

```
make requirements
```
to install prerequisite software (Ubuntu-like only), and:

```
make randomizer_release
```
to build.

If that doesn't work, see the `randomprime` build instruction for more details.

# Known Issues
- Doors that connect rooms vertically (like under the statue in Hall of the Elders) cannot be changed from their default color.

# Questions
You can find me on various Metroid Prime Discord servers as toasterparty#9244
