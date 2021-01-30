#!/usr/bin/expect -f
spawn -noecho bash
expect ": " # may need to be "$ "
set arg1 [lindex $argv 0]
send $arg1
send "\n"
interact
