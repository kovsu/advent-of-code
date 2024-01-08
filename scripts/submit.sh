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

if [ ! -n "$2" ]; then
    >&2 echo "Argument is required for day."
    exit 1
fi

if [ ! -n "$3" ]; then
    >&2 echo "Argument is required for part."
    exit 1
fi

if [ ! -n "$4" ]; then
    >&2 echo "Argument is required for answer."
    exit 1
fi


year=$(echo $1 | sed 's/^0*//');
day=$(echo $2 | sed 's/^0*//');
part=$(echo $3 | sed 's/^0*//');
answer=$4

session=".adventofcode.session";

aoc submit --day $day --year $year --session-file $session $part $answer;

