# Plando Creation Guide
This guide will walk you through how to make your own plando. If you still have questions after reading this, feel free to reach out to me on discord (toasterparty#9244). This guide was written specifically for v1.6, so there may be differences if you aren't using this version.

## 1 - Creating a New Layout
Plandos are distributed using the world_layout.json file. You can send this file amongst your friends to play each others' layouts. Keep in mind that you must be on the same version. After making a layout, post it in #prime-permalink-sharing and I will include it in the next plandomizer release.

To make a new layout, first decide which template in `/plandos/_templates/` you would like to use as a starting point. [Read about the templates here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/plandos/_templates/readme.md).

Once decided, copy the `world_layout.json` file of the template you would like to use and open it with a text editor. You will be changing the values provided in this file to affect how the game gets plandomized.

## 2 - Room Name Format
There are a couple places in the file where you need to specify specific rooms in the game. This is done using the following format:
```
"WorldName:RoomName"
```

Where `WorldName` is one of the following:
- `Frigate`
- `Tallon`
- `Chozo`
- `Magmoor`
- `Phendrana`
- `Mines`
- `Crater`

And `RoomName` is the name of the room you see on the in-game map. Note that these are case-insensitive, but they get used in-game for the elevator text so you might want proper capitalization anyways.

Additionally, you can use `"Credits"` instead of a room name to take the player straight to the credits, bypassing all remaining bosses.

*Note1: Patcher will fail if you provide a room which is on the Frigate, but `"skip_frigate":true` is set.*

*Note2: Some rooms can't be warped to for some reason. If you encounter this, just pick another room.*

## 3 - Patch Settings

In the `"patch_settings"` section of the json file, you will noticed the below settings. Set them as desired:

- `enable_one_way_doors` - Set to `true` to enable main plaza ledge door
- `fix_flaaghra_music` - Set to `true` to fix something about flaahgra using your trilogy iso
- `trilogy_iso` - Path to trilogy iso for above fix
- `patch_map` - Set to `true` to update the game map with new door colors. Note that vertical doors are still stuck vanilla colors.
- `powerbomb_lockpick` - Set to `true` to be able to open any door with a power bomb
- `skip_crater` - Set to `true` to make any elevator that leads to impact crater actually take you to the credits.
- `skip_frigate` - Set to `true` to skip the frigate. Note that setting `false` removes the frigate from the game completely, so do not send any elevators to the frigate if you do this.
- `skip_hudmemo` - Set to `true` to skip the item acquisition popup message
- `obfuscate_items` - Set to `true` to hide the identity of all items until they are physically obtained
- `stagger_suit_damage` - Set to `true` to make damage resistance a function of how many suits  you have instead of Phazon suit just making you a beast.
- `varia_heat_protection` - Set to `true` to make it so that only varia gives heat protection. Set to `false` for vanilla behavior (all 3 suits give heat protection).
- `artifact_hints` - `"all"` means the artifact temple will show hints for all artifacts in play from the beginning. `"none"` means that you never get any hints. `"default"` means that it works like it does in the vanilla game
- `auto_enabled_elevators` - Set to `true` to remove the need to scan elevators before using them. Helps open up seeds where you don't start with scan visor.
- `patch_power_conduits` - Set to `true` to make all conduits activated
- `remove_missile_locks` - Set to `true` to remove all missile locks from the game. If you only want to remove specific locks, see [missile_locks.md](https://github.com/blakespangenberg/metroid-prime-plandomizer/tree/main/doc/missile_locks.md) for details.
- `remove_frigidite_lock` - Set to `true` to remove the ice stopping you from getting into Omega Pirate's room without plasma beam
- `remove_mine_security_station_locks` - Set to `true` to let the player pass though Mine Security Station without killing all the Wave Troopers
- `lower_mines_backwards` - Set to `true` to remove various forcefields in lower mines to allow the player to traverse it backwards
- `tiny_elvetator_samus` - Set to `true` for a fun *little* gag when riding elevators

## 4 - Spawn Rooms
Using the format defined in section `2 - Room Name Format` set your spawn room(s) by defining the following:
- `new_save_spawn_room` - Room the player spawns in immediately after creating a new save file.
- `frigate_done_spawn_room` - Room the player spawns in after finishing the frigate. If this is set to `"Tallon:Landing Site"`, the player will be given the items specified by `frigate_done_starting_items`. This is unused if `"skip_frigate":true`

## 5 - Starting Pickups
Determine and set your starting items number. This single number determines all of the items the player starts with at the start of the game. If you want the player to spawn with just scan visor, just use `1`. Otherwise, to figure out what number you need - 

First, note down the numbers corresponding to each of the starting items.

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

...and so you would use `1048594`. Note that this means the player literally start with *9/9 missiles* not *9 missile packs*. For testing purposes, you can use `68719476735` to start with every item in the game.

There are two configuration options which take a starting items number:
- `new_save_starting_items` - The items the player spawns with after starting a new save file
- `frigate_done_starting_items` - The items the player spawns with after finishing the frigate and landing at landing site. This is unused if either the Frigate is skipped, or the TallonIV spawn room isn't landing site.

## 6 - Door Layout

Under `"excluded_doors"`, you will see all of the rooms names in the games. Set each door's colors in each room as desired by changing each of the options to any of the following:
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
- `"power_only"` - Only power beam opens this door. Use it as a workaround for the related known issue.
- `"random"` - The door's color will be randomly chosen using the provided `"seed"` value and the provided `"door_weights"` (does not pick from custom door types).

Note that doors are represented as an array of door for each room starting with index 0, 1, 2 etc... To figure out what index in the room array a specific door use the annotated game maps provided [here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/doc/maps/readme.md), or in the `/doc/maps` directory. For example if a room's doors are `["blue","white","red"]`, then door:0 will be blue, door:1 will be white and door:2 would be red on the map.

## 7 - Layout String
You'll notice a bunch of random characters in the `"layout_string"` property. These characters define where the elevators go and what items are placed where. To create/edit layout strings use the [Syncathetic's web tool located here](https://aprilwade.github.io/randomprime/editor.html).

Using the above web tool, place the desired items at each location and set the destinations of each elevator. When you are done, copy the resulting layout string and paste it back into your `world_layout.json` file.

*Note1: You can paste in an existing layout string to parse and edit it, as opposed to having to start from scratch each time you open the web page.*

*Note2: You can place as many artifacts into the world as you would like, including 0. The ridley fight will start when no artifacts remain to be collected.*

### Elevator Overrides
The web tool only allows for other elevators to be used as destinations. If you would like to use other specific rooms as elevator destinations, see [missile_locks.md](https://github.com/blakespangenberg/metroid-prime-plandomizer/tree/main/doc/elevator_overrides.md) for details.

## 8 - Superheated Rooms
The property `"superheated_rooms"` lets you set any room in the game to do constant heat damage without Varia Suit. It's formatted as an array of room names using the format defined in section `2 - Room Name Format`. For example:

```
"superheated_rooms":["Chozo:Main Plaza", "Tallon:Landing Site"],
```

Will make Main Plaza and Landing Site deal heat damage in addition to the vanilla magmoor/magma_pool rooms.

## 9 - Drain Water from Rooms
Much like section `8 - Superheated Rooms`, a list of rooms can be specifed with `"drain_liquid_rooms"` to specify any room in the game to remove all liquds from. This stil leaves certain effects behind such as bubbles, fish, lava popping, etc. For example:

```
"drain_liquid_rooms":["Chozo:Magma Pool", "Tallon:Frigate Crash Site"],
```

Would drain all the lava and water in those two rooms.

# Playtesting
Here are some useful tips for playtesting:
- If you patch your iso with Prime Practice Mod first, then the Plandomizer Patcher, you can use the practice mod menu to warp to any room in the game and edit your inventory.
- `"new_save_starting_items":68719476735` - spawns you with all items in game
- `"powerbomb_lockpick":true` - lets you open any door with a power bomb
