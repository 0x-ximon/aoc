use aoc_07::first;
use std::{error::Error, fs};

mod main_test;

fn main() -> Result<(), Box<dyn Error>> {
    let data = fs::read_to_string("input.txt")?;

    let first_answer = first(data.lines());
    println!("First Answer: {first_answer}");

    Ok(())
}
