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



while true; do
    echo -e "\033[42mAdvent of Code\033[0m
\033[1;31mYear: $year, Day: $day\033[0m\n"
    echo -e "  \033[1;36m1.Scanffold
  2.Download
  3.Submit
  4.Calender
  5.Clear Terminal
  6.Exit\033[0m\n"

    read operation

    if [ "$operation" = "1" ]; then
        source ./scripts/download.sh $year $day
        
    elif [ "$operation" = "2" ]; then
        source ./scripts/scanffold.sh $year
    elif [ "$operation" = "3" ]; then
        echo "Which part do you want to submit?"
        read part

        echo "What is your answer?"
        read answer

        source ./scripts/submit.sh $year $day $part $answer
    elif [ "$operation" = "4" ]; then
        source ./scripts/calender.sh $year $day
    elif [ "$operation" = "5" ]; then
        clear
    elif [ "$operation" = "6" ]; then
        echo "exit!"
        exit 0
    else
        echo "Invalid operation."
    fi
done
