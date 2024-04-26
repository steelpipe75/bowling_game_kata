import { expect, test } from "bun:test";
import { BowlingGame } from "./bowling_game";

test("All zeros game", () => {
    const bg = new BowlingGame();
    Array.from({ length: 20 }).forEach(() => {
        bg.roll(0)
    });
    expect(bg.score()).toBe(0);
});

test("All one game", () => {
    const bg = new BowlingGame();
    Array.from({ length: 20 }).forEach(() => {
        bg.roll(1)
    });
    expect(bg.score()).toBe(20);
});

test("One spare game", () => {
    const bg = new BowlingGame();
    bg.roll(5)
    bg.roll(5)
    bg.roll(3)
    Array.from({ length: 17 }).forEach(() => {
        bg.roll(0)
    });
    expect(bg.score()).toBe(16);
});

test("One strike game", () => {
    const bg = new BowlingGame();
    bg.roll(10)
    bg.roll(3)
    bg.roll(4)
    Array.from({ length: 16 }).forEach(() => {
        bg.roll(0)
    });
    expect(bg.score()).toBe(24);
});

test("Perfect game", () => {
    const bg = new BowlingGame();
    Array.from({ length: 12 }).forEach(() => {
        bg.roll(10)
    });
    expect(bg.score()).toBe(300);
});
