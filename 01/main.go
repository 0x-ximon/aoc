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
	var dial, delta, password int64 = 50, 0, 0

	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		line := scanner.Text()

		direction := line[0]
		distance, err := strconv.ParseInt(line[1:], 10, 64)
		if err != nil {
			log.Fatalln(fmt.Errorf("number conversion failed => %w", err))
		}

		// (d%m + m) % m
		switch direction {
		case 'L':
			delta = dial - distance
		case 'R':
			delta = dial + distance
		}

		dial = ((delta % 100) + 100) % 100
		if dial == 0 {
			password++
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
