
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

...and so you would use `"starting_pickups":1048594`. Note that this means the player literally start with *9/9 missiles* not *9 missile packs*. For testing purposes, you can use `"starting_pickups":68719476735` to start with every item in the game.

3. Set your `patch_settings` as desired. Most are self-explanatory booleans (`true`/`false`), but here's some notable ones:
- `skip_hudmemos` - Set to `true` to skip the message that pops up when you pick up an item
- `enable_one_way_doors` - Set to `true` if you want to be able to get to vault from the main plaza ledge
- `artifact_hints` - `"all"` means the artifact temple will show hints for all artifacts in play from the beginning. `"none"` means that you never get any hints. `"default"` means that it works like it does in the vanilla game
- `varia_heat_protection` - Set to `true` to make it so that only varia gives heat protection. Set to `false` for vanilla behavior (all 3 suits give heat protection).
- `powerbomb_lockpick` - Set to `true` to make all doors vulnerable to power bombs

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

Note that doors are represented as an array of door for each room starting with index 0, 1, 2 etc... To figure out what index in the room array a specific door use the annotated game maps provided [here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/doc/maps/readme.md), or in the `/doc/maps` directory. For example if a room's doors are `["blue","white","red"]`, then door:0 will be blue, door:1 will be white and door:2 would be red on the map.

5. Set the item layout, elevator layout and starting room by providing a custom `"layout_string"`. The best way to make a layout string is using [Syncathetic's web tool](https://aprilwade.github.io/randomprime/editor.html). Note that you can paste in an existing layout string to parse and edit it, as opposed to having to start from scratch each time you open the web page. Note that you can place as many artifacts into the world as you would like, including 0. The artifact temple will open when no artifacts remain to be collected.
