use crate::solutions::*;
use std::env;
use std::fmt::Display;
use std::time::Instant;
use aoc::read_file;

mod solutions;

static ANSI_ITALIC: &str = "\x1b[3m";
static ANSI_BOLD: &str = "\x1b[1m";
static ANSI_RESET: &str = "\x1b[0m";

fn print_result<T: Display>(func: impl FnOnce(&str) -> T, input: &str) {
  let timer = Instant::now();
  let result = func(input);
  let time = timer.elapsed();
  println!(
      "{} {}(elapsed: {:.2?}){}",
      result, ANSI_ITALIC, time, ANSI_RESET
  );
}

macro_rules! solve_day {
  ($day:path, $input:expr) => {{
      use $day::*;
      println!("----");
      println!("");
      println!("🎄 {}Part 1{} 🎄", ANSI_BOLD, ANSI_RESET);
      println!("");
      print_result(part_one, $input);
      println!("");
      println!("🎄 {}Part 2{} 🎄", ANSI_BOLD, ANSI_RESET);
      println!("");
      print_result(part_two, $input);
      println!("");
      println!("----");
  }};
}

fn main() {
  let args: Vec<String> = env::args().collect();
  let year: i32 = args[1].clone().parse().unwrap();
  let day: u8 = args[2].clone().parse().unwrap();
  
  let input = read_file("inputs", year, day);

  match year {
      2021 => {
          match day {
             1 => solve_day!(year_2021::day_01, &input),
             2 => solve_day!(year_2021::day_02, &input),
             3 => solve_day!(year_2021::day_03, &input),
            _ => println!("2021 {} not solved yet", day),
          }
      },
      _ => println!("year not solved: {}", year),
  }
}
