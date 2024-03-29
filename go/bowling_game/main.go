package main

import (
	"bowling_game/bowling_game"
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	bg := bowling_game.BowlingGame{}

	args := os.Args
	if len(args) < 2 {
		fmt.Printf("Usage: go run %s <file>\n", args[0])
		os.Exit(1)
	}

	filename := args[1]

	file, err := os.Open(filename)
	if err != nil {
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		pins, err := strconv.Atoi(line)
		if err != nil {
			os.Exit(1)
		}
		if pins < 0 {
			break
		}
		bg.Roll(pins)
		// fmt.Println(pins)
	}

	score := bg.Score()
	fmt.Println(score)
}
