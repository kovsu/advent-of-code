#!/bin/bash

set -e;

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
example_path="src/examples/$year/$filename.txt";
puzzle_path="src/puzzles/$year/$filename.md";
module_path="src/solutions/year_$year/$filename.rs";

# 首次添加年份
if [ ! -d $(dirname $module_path) ]; then
    mkdir -p $(dirname $module_path);
    touch "$(dirname $module_path)/mod.rs";
    line="      $year => {
          match day {
            _ => println!(\"$year {} not solved yet\", day),
          }
      },"
    perl -pi -le "print '$line' if(/^*.year not solved/);" "src/main.rs";

    LINE="pub mod year_$year;";
    FILE="src/solutions/mod.rs";
    grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE";
fi

if [ ! -f $(dirname $input_path) ]; then
    mkdir -p $(dirname $input_path);
fi

if [ ! -f $(dirname $puzzle_path) ]; then
    mkdir -p $(dirname $puzzle_path);
fi

if [ ! -f $(dirname $example_path) ]; then
    mkdir -p $(dirname $example_path);
fi

touch $module_path;

cat > $module_path <<EOF
pub fn part_one(input: &str) -> u32 {
    0
}

pub fn part_two(input: &str) -> u32 {
    0
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        use aoc::read_file;
        let input = read_file("examples", year, day);
        assert_eq!(part_one(&input), 0);
    }

    #[test]
    fn test_part_two() {
        use aoc::read_file;
        let input = read_file("examples", year, day);
        assert_eq!(part_two(&input), 0);
    }
}
EOF

perl -pi -e "s/year/$year/g; s/day/$day/g;" $module_path

echo "Created module \"$module_path\"";

touch $input_path;
echo "Created input file \"$input_path\"";

touch $puzzle_path;
echo "Created puzzle file \"$puzzle_path\"";

touch $example_path;
echo "Created example file \"$example_path\"";

line="             $day => solve_day!(year_$year::$filename, &input),"
perl -pi -le "print '$line' if(/^.*println!\(\"$year \{\} not solved yet\", day\),/);" "src/main.rs"


echo "Linked new module in \"src/main.rs\"";

LINE="pub mod $filename;";
FILE="src/solutions/year_$year/mod.rs";
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE";
echo "Linked new module in \"$FILE\"";


cat <<EOF
   _==_ _
 _,(",)|_|
  \/. \-|
__( :  )|_  Done!
EOF
