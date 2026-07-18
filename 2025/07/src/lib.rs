use std::str::Lines;

pub fn first(data: Lines) -> u64 {
    let mut beams: Vec<u8> = Vec::new();
    let mut lines = data.into_iter();
    let mut result: u64 = 0;

    if let Some(start) = lines.next() {
        for c in start.chars() {
            match c {
                'S' => beams.push(1),
                _ => beams.push(0),
            }
        }
    }

    for line in lines {
        let mut splits = 0;
        for (i, c) in line.chars().enumerate() {
            if c == '^' && beams[i] == 1 {
                let n = beams.len() - 1;
                beams[i] = 0;
                splits += 1;

                if i > 0 {
                    let p = i - 1;
                    beams[p] = 1;
                }

                if i < n {
                    let q = i + 1;
                    beams[q] = 1;
                }
            };
        }

        result += splits;
    }

    return result;
}

pub fn second(data: Lines) -> u64 {
    let mut beams: Vec<u64> = Vec::new();
    let mut lines = data.into_iter();
    let mut result: u64 = 0;

    if let Some(start) = lines.next() {
        for c in start.chars() {
            match c {
                'S' => beams.push(1),
                _ => beams.push(0),
            }
        }
    }

    for line in lines {
        for (i, c) in line.chars().enumerate() {
            if c == '^' && beams[i] > 0 {
                let n = beams.len() - 1;

                if i > 0 {
                    let p = i - 1;
                    beams[p] += beams[i];
                }

                if i < n {
                    let q = i + 1;
                    beams[q] += beams[i];
                }

                beams[i] = 0;
            }
        }
    }

    for beam in beams {
        result += beam;
    }

    return result;
}
