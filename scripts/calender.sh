#!/bin/bash

set -e;

if ! command -v 'aoc' &> /dev/null
then
    echo "command \`aoc\` not found. Try running \`cargo install aoc-cli\` to install it."
    exit 1
fi

if [ ! -n "$1" ]; then
    >&2 echo "Argument is required for year."
    exit 1
fi

year=$(echo $1 | sed 's/^0*//');

session=".adventofcode.session";

aoc calendar --year $year --session-file $session --overwrite;

