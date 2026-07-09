package main

import (
	"strings"
	"testing"
)

func Test_Process(t *testing.T) {
	data := "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82\n"
	//									  ^
	//									  5
	//									  Bug happens here.

	reader := strings.NewReader(data)

	expected := int64(6)
	actual := process(reader)

	if expected != actual {
		t.Errorf("expected: %d, actual: %d", expected, actual)
	}
}
