package main

import "core:fmt"

import rl "vendor:raylib"

// The game singleton
game: Game

main :: proc() {
	rl.InitWindow(1024, 1024, "Odin Playground")
	defer rl.CloseWindow()

	game = game_init()

	for !rl.WindowShouldClose() {
		game_update(&game)
		render()
	}
}


render :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.DARKGRAY)
	defer rl.EndDrawing()

	game_render(&game)
}
