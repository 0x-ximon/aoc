package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		log.Fatalln(fmt.Errorf("could not get file => %w", err))
	}
	defer f.Close()

	reader := bufio.NewReader(f)
	scanner := bufio.NewScanner(reader)
	if scanner.Err() != nil {
		log.Fatalln(fmt.Errorf("scanner error => %w", scanner.Err()))
	}

	var data []string
	for scanner.Scan() {
		line := scanner.Text()
		data = append(data, line)
	}

	firstAnswer := first(data)
	fmt.Printf("First Answer: %d\n", firstAnswer)

	secondAnswer := second(data)
	fmt.Printf("Second Answer: %d\n", secondAnswer)
}
