package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"os"
	"strconv"
)

func process(r io.Reader) int64 {
	var dial int64 = 50
	var password int64 = 0

	scanner := bufio.NewScanner(r)
	if scanner.Err() != nil {
		log.Fatalln(fmt.Errorf("scanner error => %w", scanner.Err()))
	}

	for scanner.Scan() {
		line := scanner.Text()

		direction := line[0]
		difference, err := strconv.ParseInt(line[1:], 10, 64)
		if err != nil {
			log.Fatalln(fmt.Errorf("number conversion failed => %w", err))
		}

		password += difference / 100
		step := difference % 100

		switch direction {
		case 'L':
			delta := dial - step
			if dial > 0 && delta <= 0 {
				password++
			}
			dial = (delta + 100) % 100

		case 'R':
			delta := dial + step
			if dial > 0 && delta >= 100 {
				password++
			}
			dial = (delta + 100) % 100
		}
	}

	return password
}

func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		log.Fatalln(fmt.Errorf("could not get file => %w", err))
	}
	defer f.Close()

	reader := bufio.NewReader(f)
	password := process(reader)

	fmt.Printf("Password: %d\n", password)
}
