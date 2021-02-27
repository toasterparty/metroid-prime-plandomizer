# Metroid Prime Plandomizer

This is a collection of tools needed to make and play plandos for Metroid Prime. What is a plando you ask? It's a portemanteau of "planned" and "randomizer", or a non-vanilla item/elevator/door configuration to be played through using sequence-breaks. It's also technically an oxymoron.

Designing seeds instead of using randomly chosen ones allows for finely tuned difficulty, reduces back-tracking and can often provide gameplay experiences you wouldn't ever naturally encounter in a logic-based randomizer. As people make plandos, I'll add them to the repository under the `/plandos/` directory.

Eventually this project will be merged upstream so that it can be used with, Bash's GUI. In the meantime, please feel free to use in it's in-dev state.

# Features
- Share your work with a single text file
- Settable items/locations
- Settable elevator destinations
- 10 new non-vanilla door types with custom textures and damage profiles
- Choose which rooms are superheated
- Spawn in any room
- Map elevators to any room
- Other patch settings to help open up the world such as:
    - Power beam activated power conduits
    - Remove frigidite above door in Elite Quarters Access
    - Remove missile locks
- All the randomizer bells and whistles you're used to (frigate skip, item pickup message skip, 0-12 required artifacts etc...)

# How to Play a Plando
1. Go to the "releases" tab on the right and download the latest version for your platform and extract the contents onto your PC
2. Copy your unmodified Metroid Prime ROM into the root directory and name it `prime.iso`
3. Copy the `world_layout.json` file of the plando you wish to play into the root directory
4. Run `patch.bat` (or `patch.sh` on linux) and wait for patching to complete
5. Load the output iso file into your Dolphin, Wii, TI-84 etc. You are ready to play!
6. Note that as you play, you may encounter non-vanilla doors types. Click [here](https://github.com/blakespangenberg/metroid-prime-plandomizer/blob/main/doc/doors/readme.md) to view a list of all the new door types and their vulnerabilities. Additionally, you should keep in mind that the following options are availible to plando-makers:
- Power Conduits activated by all weapons
- Remove Missile Locks
- Remove Door Locks in Mine Security Station
- Remove Frigidite in Elite Quarters Access

# How to Make a Plando
[Read the guide here](https://github.com/blakespangenberg/metroid-prime-plandomizer/tree/main/doc/readme.md)

# Known Issues
*This has only ever been tested on NTSC v1.0. There may be additional issues with non NTSC v1.0 versions*
- Vertical doors will always show their vanilla color on the map
- When using specific rooms as elevator destinations (or as spawn room), various strange things may occur. This includes:
    - Spawning you in a different room than the one specified
    - Spawning you out of bounds
    - Loosing/gaining items
    
    If this happens, just pick a different room. For some reason, this happens with almost every frigate room.
    - Players can keep a single beam through the frigate item loss cutscene by having it equipped when the frigate collapse cutscene starts. They can keep the beam for as long as they don't switch back to power beam. For this exact reason "power_only" doors were added to the plandomizer, to force players to switch to power beam.
- There's two rooms with the same name in Frigate. They both get patched with the doors specified in layout.
- If the frigate is accessible after landing on the planet, the starting items given to the player after finishing the level are only given if the destination is landing site
- Under certain conditions, samus' ship in landing site can be invisible - You can still save and do SJF though


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

If that doesn't work, see the `randomprime` build instruction for more details. There's also some windows batch files in `/tools/win` you can look at.

# Questions
You can find me on various Metroid Prime Discord servers as toasterparty#9244
