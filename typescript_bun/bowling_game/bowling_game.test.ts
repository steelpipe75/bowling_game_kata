import { describe, beforeEach, expect, test } from "bun:test";
import { BowlingGame } from "./bowling_game";

describe("Bowling Game", () => {
    let bg: BowlingGame;

    beforeEach(() => {
        bg = new BowlingGame();
    });

    function rollMany(game: BowlingGame, times: number, pins: number) {
        for (let i = 0; i < times; i++) {
            game.roll(pins);
        }
    }

    test("All zeros game", () => {
        rollMany(bg, 20, 0);
        expect(bg.score()).toBe(0);
    });

    test("All one game", () => {
        rollMany(bg, 20, 1);
        expect(bg.score()).toBe(20);
    });

    test("One spare game", () => {
        bg.roll(5);
        bg.roll(5);
        bg.roll(3);
        rollMany(bg, 17, 0);
        expect(bg.score()).toBe(16);
    });

    test("One strike game", () => {
        bg.roll(10);
        bg.roll(3);
        bg.roll(4);
        rollMany(bg, 16, 0);
        expect(bg.score()).toBe(24);
    });

    test("Perfect game", () => {
        rollMany(bg, 12, 10);
        expect(bg.score()).toBe(300);
    });
});
