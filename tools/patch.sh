#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

LAYOUT_FILE=$SCRIPT_DIR/world_layout.json
if test ! -f "$LAYOUT_FILE"; then
    echo "Error: $LAYOUT_FILE could not be found!" && exit 1
fi

ISO_FILE=$SCRIPT_DIR/prime.iso
if test ! -f "$ISO_FILE"; then
    echo "Error: $ISO_FILE could not be found!" && exit 1
fi

RUST_BACKTRACE=1 $SCRIPT_DIR/plandomizer_patcher --profile $SCRIPT_DIR/world_layout.json
