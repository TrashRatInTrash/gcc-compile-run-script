#!/bin/bash

LIBRARIES=""
PARAMETERS=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -l)
            shift
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                LIBRARIES+=" -l$1"
                shift
            done
            ;;
        -p)
            shift
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                PARAMETERS+=" $1"
                shift
            done
            ;;
        *)
            if [[ -z "$C_FILE" ]]; then
                C_FILE="$1"
            else
                echo "Unknown option or too many arguments: $1"
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$C_FILE" ]]; then
    echo "Usage: $0 <filename.c> [-l library1 library2 ...] [-p param1 param2 ...]"
    exit 1
fi

BASENAME=$(basename "$C_FILE" .c)

gcc -o "$BASENAME.o" "$C_FILE" $LIBRARIES


if [[ $? -eq 0 ]]; then
    ./"$BASENAME.o" $PARAMETERS
else
    echo "Compilation failed."
    exit 1
fi
