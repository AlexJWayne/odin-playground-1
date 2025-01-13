package main

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"


Particle :: struct {
	age, lifetime: f32,
	pos, vel:      rl.Vector2,
	alive:         bool,
}

COUNT :: 50_000
SPEED :: 250
LIFETIME :: 3
RATE :: 30_000

count := 0

ParticleSystem :: struct {
	particles:    [COUNT]Particle,
	spawn_cursor: int,
}

particles_init :: proc() -> ParticleSystem {
	return ParticleSystem{}
}

particle_init :: proc() -> Particle {
	vel :=
		rl.Vector2Normalize((rl.Vector2{rand.float32(), rand.float32()} - 0.5)) *
		((rand.float32() * 0.5 + 0.5) * SPEED)

	return Particle {
		alive    = true, //
		age      = 0,
		lifetime = 1.5,
		pos      = game.player.pos,
		vel      = vel,
	}
}

particles_update :: proc(system: ^ParticleSystem) {
	if rl.Vector2Length(game.player.vel) > 0 {
		particle_spawn(system, cast(int)(RATE * rl.GetFrameTime()))
	}

	// fmt.printfln("%1.f alive", count)

	for &particle in system.particles {
		if !particle.alive {continue}

		frame_time := rl.GetFrameTime()
		particle.pos += particle.vel * frame_time

		particle.alive = particle.age < particle.lifetime
		if !particle.alive {count -= 1}
		particle.age += frame_time
	}
}

particle_spawn :: proc(system: ^ParticleSystem, qty: int) {
	for i in 0 ..< qty {
		system.particles[system.spawn_cursor] = particle_init()
		system.spawn_cursor += 1
		count += 1
		if system.spawn_cursor >= COUNT {
			system.spawn_cursor = 0
		}
	}
}

particles_render :: proc(system: ^ParticleSystem) {
	for particle in system.particles {
		if !particle.alive {continue}
		youth := 1 - (particle.age / particle.lifetime)

		rl.DrawRectangleV(
			particle.pos, //
			rl.Vector2{6, 6},
			rl.Color{0xFF, 0xFF, 0xFF, cast(u8)(youth * 0xFF)},
		)
	}
}
