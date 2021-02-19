# Metroid Prime Plandomizer

This is a collection of tools needed to make and play plandos for Metroid Prime. What is a plando you ask? It's a portemanteau of "planned" and "randomizer", or a non-vanilla item/elevator/door configuration to be played through using sequence-breaks. It's also technically an oxymoron.

Designing seeds instead of using randomly chosen ones allows for finely tuned difficulty, reduces back-tracking and can often provide gameplay experiences you wouldn't ever natrually encounter in a logic-based randomizer. As people make plandos, I'll add them to the repository under the `/plandos` directory.

Eventually this project will be merged upstream so that it can be used with, Bash's GUI. In the meantime, please feel free to use in it's in-dev state.

# Features
- Settable items/locations
- Settable elevator desitnations
- Settable door colors
    - 10 extra door colors
- All the randomizer bells and whistles you're used to (frigate skip, item pickup message skip, 0-12 required artifacts etc...)

# How to Play a Plando
1. Go to the "releases" tab on the right and download the latest version for your platform and extract the contents onto your PC
2. Copy your unmodified Metroid Prime ROM into the root directory and name it `prime.iso`
3. Copy the `world_layout.json` file of the plando you wish to play into the root directory
4. Run `patch.bat` (or `patch.sh` on linux) and wait for patching to complete
5. Load `prime_out.iso` into your Dolphin, Wii, TI-84 etc. You are ready to play!
6. Note that as you play, you may encounter non-vanilla doors types. Click [here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/doc/doors/readme.md) to view a list of all the new door types and their vulnerabilities.

# How to Make a Plando
1. Make a copy of `/plandos/_template/world_layout.json` and open in a text editor. This file contains a preset for all vanilla item locations, elevator destinations and door colors.

2. Determine and set your `"starting_pickups"` number. This single number determines all of the items the player starts with at the start of the game. To figure out what number you need, first, note down the numbers corresponding to each of the starting items.

```
scan visor         - 1 
1 missile          - 2
2 missiles         - 4
4 missiles         - 8
8 missiles         - 16
16 missiles        - 32
32 missiles        - 64
64 missiles        - 128
128 missiles       - 256
1 e-tank           - 512
2 e-tanks          - 1024
4 e-tanks          - 2048
8 e-tanks          - 4096
1 power bombs      - 8192
2 power bombs      - 16384
4 power bombs      - 32768
8 power bombs      - 65536
wave               - 131072
ice                - 262144
plasma             - 524288
charge             - 1048576
morph ball         - 2097152
bombs              - 4194304
spider ball        - 8388608
boost ball         - 16777216
varia suit         - 33554432
gravity suit       - 67108864
phazon suit        - 134217728
thermal visor      - 268435456
xray               - 536870912
space jump         - 1073741824
grapple            - 2147483648
super missile      - 4294967296
wavebuster         - 8589934592
ice spreader       - 17179869184
flamethrower       - 34359738368
```

Then, simply sum the numbers together. For example, if the starting items are charge and 9 missiles. That would be:

```
(charge) + (8 missiles) + (1 missile)
1048576 + 16 + 2
1048594
```

...and so you would use `"starting_pickups":1048594`. Note that this means the player literally start with *9/9 missiles* not *9 missile packs*. For testing purposes, you can use to `"starting_pickups":68719476735` to start with every item in the game.

3. Set your `patch_settings` as desired. Most are self-explainitory booleans (`true`/`false`), but here's some notable ones:
- `patch_vertical_to_blue` - Set to `true` to make all doors that connect rooms vertically (e.g. Tower Chamber/Tower of Light) blue. Set to `false` to leave them as vanilla colors. Note that those are your only two options for vertical doors, you cannot set custom door colors on vertical doors.
- `skip_hudmemos` - Set to `true` to skip the message that pops up when you pick up an item.
- `enable_one_way_doors` - Set to `true` if you want to be able to get to vault from the main plaza ledge
- `artifact_hints` - `"all"` means the artifact temple will show hints for all artifacts in play from the beggining. `none` means that you never get any hints. `"default"` means that it works like it does in the vanilla game.
- `varia_heat_protection` - Set to `true` to make it so that only varia gives heat protection. Set to `false` for vanilla behavior (all 3 suits give heat protection).
- `powerbomb_lockpick` - Set to `true` to make all doors vulnerable to power bombs.

4. Under `"excluded_doors"`, you will see all of the rooms names in the games. Set each door's colors in each room as desired by changing each of the options to any of the following:
- `"default"` - The door will be unpatched (remain vanilla color for that location)
- `"blue"` - Any Beam
- `"purple"` - Wave Beam
- `"white"` - Ice Beam
- `"red"` - Plasma Beam
- `"missile"` - Missile door (different than a missile lock)
- `"bomb"` - Morph Ball Bombs
- `"charge"` - Charge Beam
- `"power_bomb"` - Power Bombs
- `"super"` - Super Missile
- `"wavebuster"` - Wave Beam Charge Combo
- `"icespreader"` - Ice Beam Charge Combo
- `"flamethrower"` - Plasma Beam Charge Combo
- `"ai"` - Only opens from enemy weapon fire
- `"disabled"` - Nothing opens this door (Technically Phazon beam can open if you can find a way to hack it in)
- `"random"` - The door's color will be randomly chosen using the provided `"seed"` value and the provided `"door_weights"` (does not pick from custom door types).

Note that doors are represented as an array of door for each room starting with index 0, 1, 2 etc... To figure out what index in the room array a specific door use the annotated game maps provided [here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/doc/maps/readme.md), or in the `/doc/maps` directory. For example if a room's doors are `["blue","white","red"]`, then door:0 will be blue, door:1 will be white and door:2 would be red on the map. Also note the location of vertical doors on the map. These cannot be changed apart from setting the `patch_vertical_to_blue` option to `true`.

5. Set the item layout, elevator layout and starting room by providing a custom `"layout_string"`. The best way to make a layout string is using [Syncathetic's web tool](https://aprilwade.github.io/randomprime/editor.html). Note that you can paste in an existing layout string to parse and edit it, as opposed to having to start from scratch each time you open the web page. Note that you can place as many artifacts into the world as you would like, including 0. The artifact temple will open when no artifacts remain to be collected.

# Known Issues
- Doors that connect rooms vertically must either be all blue, or all vanilla colors. If patched to blue, the map will (incorrectly) display the orignal color.
- Main plaza ledge door will always be blue
- Randomly picked doors cannot be custom door types
- No completion logic for randomly picked doors
- Cannot patch un-crashed frigate or impact crater doors

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

# Questions
You can find me on various Metroid Prime Discord servers as toasterparty#9244
