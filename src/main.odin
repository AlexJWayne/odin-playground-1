package main

import "core:fmt"

import rl "vendor:raylib"

// The game singleton
game: Game

main :: proc() {
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(1024, 1024, "Odin Playground")
	rl.SetTargetFPS(500)
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

	draw_fps()
}

draw_fps :: proc() {
	fps := 1 / rl.GetFrameTime()
	fps_cstring := fmt.ctprintf("FPS: %1.f", fps)
	rl.DrawText(fps_cstring, 5, 5, 20, rl.WHITE)
}
