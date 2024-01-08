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

year=$(echo $1 | sed 's/^0*//');

day=$(echo $2 | sed 's/^0*//');
day_padded=`printf %02d $day`;

filename="day_$day_padded";
input_path="src/inputs/$year/$filename.txt";

tmp_dir=$(mktemp -d);
tmp_file_path="$tmp_dir/input";

puzzle_path="src/puzzles/$year/day_$day_padded.md";

session=".adventofcode.session";

aoc download --year $year --day $day --input-file $tmp_file_path --session-file $session --puzzle-file $puzzle_path --overwrite;
cat $tmp_file_path > $input_path; 
echo "Wrote input to \"$input_path\"...";

cat <<EOF
   _==_ _
 _,(",)|_|
  \/. \-|
__( :  )|_  Done!
EOF

# Make sure it gets removed even if the script exits abnormally.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -rf "$tmp_dir"' EXIT
