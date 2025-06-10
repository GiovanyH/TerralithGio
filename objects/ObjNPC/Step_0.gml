if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {
	move_y = gravity_speed;

	// Modifica o fator de interpolação para algo mais perceptível
	move_x = lerp(move_x, dir_x, 0.1) * (room_speed / 60);  // Aqui aumentei o fator e o valor de interpolação

	// Verifica colisão com o chão e executa pulo se estiver em movimento
	if (place_meeting(x + 2.0, y, floor_tilemap) && move_x != 0 || place_meeting(x - 2.0, y, floor_tilemap) && move_x != 0) {
	    jump();
	}

	if (on_floor(floor_tilemap)) {
		sprite_index = NpcPescador_Walk_spr;
	}
	else {
		sprite_index = NpcPescadorJump_spr;
	}

	if (dir_x < 0) {
		image_xscale = -1;
	
		var tile_x = floor(x / 16);
		var tile_y = floor(y / 16);
	
		if (tile_x - 1 > 0) {
			if (round(get_biome(World.temperature_map[tile_x - 1], World.humidity_map[tile_x-1])) != 0) {
				dir_x = 3.0;
			}
			else {
				dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -3.0, 3.0);
			}
		}
	}
	else if (dir_x > 0) {
		image_xscale = 1;
	
		var tile_x = floor(x / 16);
		var tile_y = floor(y / 16);
	
		if (tile_x + 1 < World.world_sizex) {
			if (round(get_biome(World.temperature_map[tile_x+1], World.humidity_map[tile_x+1])) != 0) {
				dir_x = -3.0;
			}
			else {
				dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -3.0, 3.0);
			}
		}
	}
	else {
		dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -3.0, 3.0);
	}

	if (move_x < -0.1) {
		image_speed = 0;
		image_index = 0;
	}
	else if (move_x > 0.1) {
		image_speed = 0;
		image_index = 0;
	}
	else {
		image_speed = 1;
	}

	move_perlin_noise += 0.01;

	move_and_collide(move_x, move_y, floor_tilemap);

	contador_tempo += 1;

	if (contador_tempo >= tempo_espera) {
	    instance_create_layer(x, y, layer, obj_ovo);
    
	    contador_tempo = 0;
	}
}