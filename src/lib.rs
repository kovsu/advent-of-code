use std::env;
use std::fs;

pub fn read_file(folder: &str, year: i32, day: u8) -> String {
    let cwd = env::current_dir().unwrap();

    let filepath = cwd
        .join("src")
        .join(folder)
        .join(format!("{}/day-{:02}.txt", year, day));

    let f = fs::read_to_string(filepath);
    f.expect("could not open input file")
}
