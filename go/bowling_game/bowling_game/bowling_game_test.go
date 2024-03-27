package bowling_game

import (
	"testing"
)

func TestAllzero(t *testing.T) {
	bg := BowlingGame{}

	for i := 0; i < 20; i++ {
		bg.Roll(0)
	}
	got := bg.Score()
	want := 0
	if got != want {
		t.Errorf("got %d, want %d", got, want)
	}
}

func TestAllones(t *testing.T) {
	bg := BowlingGame{}

	for i := 0; i < 20; i++ {
		bg.Roll(1)
	}
	got := bg.Score()
	want := 20
	if got != want {
		t.Errorf("got %d, want %d", got, want)
	}
}

func TestOnespare(t *testing.T) {
	bg := BowlingGame{}

	bg.Roll(5)
	bg.Roll(5)
	bg.Roll(3)
	for i := 0; i < 17; i++ {
		bg.Roll(0)
	}
	got := bg.Score()
	want := 16
	if got != want {
		t.Errorf("got %d, want %d", got, want)
	}
}

func TestOnestrike(t *testing.T) {
	bg := BowlingGame{}

	bg.Roll(10)
	bg.Roll(3)
	bg.Roll(4)
	for i := 0; i < 16; i++ {
		bg.Roll(0)
	}
	got := bg.Score()
	want := 24
	if got != want {
		t.Errorf("got %d, want %d", got, want)
	}
}

func TestPerfectgame(t *testing.T) {
	bg := BowlingGame{}

	for i := 0; i < 12; i++ {
		bg.Roll(10)
	}
	got := bg.Score()
	want := 300
	if got != want {
		t.Errorf("got %d, want %d", got, want)
	}
}
