package main

import "core:fmt"
import rl "vendor:raylib"

Player :: struct {
	pos:   rl.Vector2,
	vel:   rl.Vector2,
	speed: f32,
}

player_init :: proc() -> Player {
	return Player {
		pos   = rl.Vector2{25, 25}, //
		speed = 800,
	}
}

player_update :: proc(player: ^Player) {
	handle_player_input(player)
	player_update_pos(player)
}

handle_player_input :: proc(player: ^Player) {
	player.vel *= 0

	switch {
	case rl.IsKeyDown(.RIGHT):
		player.vel.x += 1
	case rl.IsKeyDown(.LEFT):
		player.vel.x -= 1
	case rl.IsKeyDown(.UP):
		player.vel.y -= 1
	case rl.IsKeyDown(.DOWN):
		player.vel.y += 1
	}
}

player_update_pos :: proc(player: ^Player) {
	player.pos += player.vel * player.speed * rl.GetFrameTime()
}

render_player :: proc(player: ^Player) {
	rl.DrawCircleV(player.pos, 30, rl.PINK)
}
