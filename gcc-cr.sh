
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <filename.c> [libraries...]"
    exit 1
fi

BASENAME=$(basename "$1" .c)

gcc -o "$BASENAME.o" "$1" "${@:2}"

if [ $? -eq 0 ]; then
    ./"$BASENAME.o"
else
    echo "Compilation failed."
    exit 1
fi
