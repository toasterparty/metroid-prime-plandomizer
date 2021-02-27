# Elevator Overrides
This section describes how to set specific rooms as elevator destinations. If you only want to use other elevators as destinations, then set them in the layout string and you're good to go. Otherwise, you'll need to add a `"elevator_layout_override"` property to your `world_layout.json` file like so:

```
    "elevator_layout_override":[
        "credits",
        "Frigate:Exterior Docking Hangar",
        "Crater:Crater Entry Point",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza",
        "Chozo:Main Plaza"
    ],
```

Make sure you *don't* add it in the `"patch_settings"` section or the `"excluded_doors"` section.

Each line in this array represents a elevator in the game. The name provided determines where that elevator will send you. The format of the destinations is formatted by section `2 - Room Name Format` of the **Plando Creation Guide**.

The positions in the array correspond to the following elevators:

1) Chozo Ruins West (Main Plaza) A.K.A Transport to Tallon Overworld North
2) Chozo Ruins North (Sun Tower) A.K.A Transport to Magmoor Caverns North
3) Chozo Ruins East (Reflecting Pool, Save Station) A.K.A Transport to Tallon Overworld East
4) Chozo Ruins South (Reflecting Pool, Far End) A.K.A Transport to Tallon Overworld South
5) Phendrana Drifts North (Phendrana Shorelines) A.K.A Transport to Magmoor Caverns West
6) Phendrana Drifts South (Quarantine Cave) A.K.A Transport to Magmoor Caverns South
7) Tallon Overworld North (Tallon Canyon) A.K.A Transport to Chozo Ruins West
8) Artifact Temple
9) Tallon Overworld East (Frigate Crash Site) A.K.A Transport to Chozo Ruins East
10) Tallon Overworld West (Root Cave) A.K.A Transport to Magmoor Caverns East
11) Tallon Overworld South (Great Tree Hall, Upper) A.K.A Transport to Chozo Ruins South
12) Tallon Overworld South (Great Tree Hall, Lower) A.K.A Transport to Phazon Mines East
13) Phazon Mines East (Main Quarry) A.K.A Transport to Tallon Overworld South
14) Phazon Mines West (Phazon Processing Center) A.K.A Transport to Magmoor Caverns South
15) Magmoor Caverns North (Lava Lake) A.K.A Transport to Chozo Ruins North
16) Magmoor Caverns West (Monitor Station) A.K.A Transport to Phendrana Drifts North
17) Magmoor Caverns East (Twin Fires) A.K.A Transport to Tallon Overworld West
18) Magmoor Caverns South (Magmoor Workstation, Debris) A.K.A Transport to Phazon Mines West
19) Magmoor Caverns South (Magmoor Workstation, Save Station) A.K.A Transport to Phendrana Drifts South
20) Crater Entry Point

*Note1: These overrides will take priority over the destinations set in the layout string.*

*Note2: Some rooms don't behave properly when used as destinations. If you encounter one of these rooms, just pick a different nearby room.*
