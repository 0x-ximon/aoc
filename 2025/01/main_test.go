package main

import (
	"bufio"
	"fmt"
	"log"
	"strings"
	"testing"
)

func Test_Process(t *testing.T) {
	raw := "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82\n"

	reader := strings.NewReader(raw)
	scanner := bufio.NewScanner(reader)
	if scanner.Err() != nil {
		log.Fatalln(fmt.Errorf("scanner error => %w", scanner.Err()))
	}

	var data []string
	for scanner.Scan() {
		line := scanner.Text()
		data = append(data, line)
	}

	firstExpected := int64(3)
	firstResult := first(data)
	if firstExpected != firstResult {
		t.Errorf("expected: %d, actual: %d", firstExpected, firstResult)
	}

	secondExpected := int64(6)
	secondResult := second(data)
	if secondExpected != secondResult {
		t.Errorf("expected: %d, actual: %d", secondExpected, secondResult)
	}
}
