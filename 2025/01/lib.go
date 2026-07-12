package main

import (
	"fmt"
	"log"
	"strconv"
)

func first(data []string) int64 {
	var dial, delta, result int64 = 50, 0, 0

	for _, line := range data {
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
			result++
		}
	}

	return result
}

func second(data []string) int64 {
	var dial, delta, result int64 = 50, 0, 0

	for _, line := range data {
		direction := line[0]
		distance, err := strconv.ParseInt(line[1:], 10, 64)
		if err != nil {
			log.Fatalln(fmt.Errorf("number conversion failed => %w", err))
		}

		result += distance / 100
		step := distance % 100

		switch direction {
		case 'L':
			delta = dial - step
			if dial > 0 && delta <= 0 {
				result++
			}
			dial = (delta + 100) % 100

		case 'R':
			delta = dial + step
			if dial > 0 && delta >= 100 {
				result++
			}
			dial = (delta + 100) % 100
		}
	}

	return result
}
