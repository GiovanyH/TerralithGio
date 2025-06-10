// Step Event do obj_EsqueletoEs1

function die() {
	is_dead = true;
}

function decrease_health(amount) {
	if (HEALTH_LEVEL > 0) HEALTH_LEVEL -= amount;
	else {
		HEALTH_LEVEL = 0;
		
		die();
	}
}

function damage() {
	if (!taking_damage) {
		sprite_index = Esqueleto1DamageHit_spr;
		part_particles_burst(ps, x, y, Damage);
		// colocar um som melhor dps
		audio_sound_pitch(DamageSFX, random_range(0.75, 1.25));
	    audio_play_sound(DamageSFX, 10, false);
			
		decrease_health(20);
		damage_cooldown = 0.0;
		
		taking_damage = true;
	}
}

if (is_dead) {
	sprite_index = EsqueletoDeath_spr;
}
else if (taking_damage) {
	sprite_index = Esqueleto1DamageHit_spr;
}
else {
	if (cooldown_arremesso > 0) {
	    cooldown_arremesso -= 1;
	}

	var distancia_para_player = point_distance(x, y, obj_Player.x, obj_Player.y);

	if (distancia_para_player <= distancia_ataque && cooldown_arremesso == 0 && !estado_atacando) {
	    sprite_index = Esqueleto1Attack_spr;
	    estado_atacando = true;
	    image_index = 0;
	}

	if (estado_atacando && image_index >= image_number - 1) {
	    var osso = instance_create_layer(x, y, "Instances", obj_OssoEsqueleto);
	    osso.direction = point_direction(x, y, obj_Player.x, obj_Player.y);
	    osso.speed = 6; 
    
	    sprite_index = Esqueleto1Idle_spr;
	    estado_atacando = false;
	    cooldown_arremesso = tempo_cooldown; 
	}
}
if (damage_cooldown > 5) {
	taking_damage = false;
	damage_cooldown = 0.0;
}
damage_cooldown += delta_time / 100000;