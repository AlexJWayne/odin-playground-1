package main

import "core:fmt"

import rl "vendor:raylib"

Player :: struct {
	position: rl.Vector2,
	speed:    f32,
}

Game :: struct {
	player:     Player,
	delta_time: f32,
}

game: Game

main :: proc() {
	rl.InitWindow(1024, 1024, "Odin Playground")
	defer rl.CloseWindow()

	game_init()

	for !rl.WindowShouldClose() {
		game_update()
		render()
	}
}

game_init :: proc() {
	game = Game {
		player = Player {
			position = rl.Vector2{100, 100}, //
			speed    = 250,
		},
	}
}

game_update :: proc() {
	game.delta_time = rl.GetFrameTime()
	handle_input()
}

handle_input :: proc() {
	player := &game.player
	distance := game.delta_time * player.speed

	switch {
	case rl.IsKeyDown(.RIGHT):
		player.position.x += distance
	case rl.IsKeyDown(.LEFT):
		player.position.x -= distance
	case rl.IsKeyDown(.UP):
		player.position.y -= distance
	case rl.IsKeyDown(.DOWN):
		player.position.y += distance
	}
}

render :: proc() {
	rl.BeginDrawing()
	defer rl.EndDrawing()
	rl.ClearBackground(rl.DARKGRAY)

	render_player()
}

render_player :: proc() {
	rl.DrawRectangleRec(
		rl.Rectangle {
			x      = game.player.position.x, //
			y      = game.player.position.y,
			width  = 100,
			height = 100,
		},
		rl.PINK,
	)
}
