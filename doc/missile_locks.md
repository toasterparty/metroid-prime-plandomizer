# Missile Locks
If you want to remove all missile locks from the game, use `"remove_missile_locks":true` and you're good to go. Otherwise keep it set to `true`, but also add a `"missile_lock_override"` line to your `world_layout.json` file like so:

```
"missile_lock_override":[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false],
```

Make sure you *don't* add it in the `"patch_settings"` section or the `"excluded_doors"` section.

Each `true`/`false` in this array represents a specific room in the game. If set to `true` there will be a missile lock. If set to `false` there will be no missile locks in that room. The positions in the array correspond to the following rooms.

1) Temple Security Station
2) Waterfall Cavern
3) Frigate Crash Site
4) Root Tunnel
5) Root Cave
6) Main Plaza 
7) Hive Totem
8) Arboretum Access
9) Arboretum
10) Gathering Hall 
11) Watery Hall Access
12) Watery Hall 
13) Dynamo Access 
14) Crossway 
15) Reflecting Pool
16) Burning Trail
17) Transport to Phendrana Drifts South
18) Ice Ruins West
19) Canyon Entryway 
20) Ruined Courtyard
21) Observatory

For rooms that have 2 missile locks, it gets rid of both.
