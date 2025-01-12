package main

import rl "vendor:raylib"

Game :: struct {
	player:          Player,
	particle_system: ParticleSystem,
}

game_init :: proc() -> Game {
	return Game {
		player          = player_init(), //
		particle_system = particles_init(),
	}
}

game_update :: proc(game: ^Game) {
	handle_player_input(&game.player)
	player_update(&game.player)
	particles_update(&game.particle_system)
}

game_render :: proc(game: ^Game) {
	particles_render(&game.particle_system)
	render_player(&game.player)
}
