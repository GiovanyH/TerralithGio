if (instance_exists(obj_Player)) {
	if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {
	
		if (on_floor(floor_tilemap)) {
			y_force_amount = 0;
			move_y = 0;
		}
		// Modifica o fator de interpolação para algo mais perceptível
		move_x = lerp(move_x, dir_x * speed_amount, 0.5) * (delta_time / 100000);  // Aqui aumentei o fator e o valor de interpolação
		// Verifica colisão com o chão e executa pulo se estiver em movimento
		if (place_meeting(x + 8.0, y, floor_tilemap) && move_x != 0.0 || place_meeting(x - 8.0, y, floor_tilemap) && move_x != 0.0) {
		    jump();
		}

		if (on_floor(floor_tilemap)) {
			sprite_index = Coelho_idle_spr;
		}
		else {
			sprite_index = Coelho_Jump_spr;
			y_force_amount = gravity_speed;
		}
	
		dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -1.0, 1.0) * overlayed_direction;
	
		move_y += y_force_amount * (delta_time / 100000);

		if (dir_x < 0) {
			image_xscale = -1;
	
			var tile_x = floor(x / 16);
			var tile_y = floor(y / 16);
	
			if (tile_x - 1 > 0) {
				if (round(get_biome(World.temperature_map[tile_x - 1], World.humidity_map[tile_x-1])) != 0) {
					overlayed_direction *= -1;
				}
			}
		}
		else if (dir_x > 0) {
			image_xscale = 1;
	
			var tile_x = floor(x / 16);
			var tile_y = floor(y / 16);
	
			if (tile_x + 1 < World.world_sizex) {
				if (round(get_biome(World.temperature_map[tile_x + 1], World.humidity_map[tile_x+1])) != 0) {
					overlayed_direction *= -1;
				}
			}
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

		move_perlin_noise += 0.01 * vontade_de_explorar;

		move_and_collide(move_x, move_y, floor_tilemap);

		// Step Event da galinha (Object9)

		// Incrementa o contador a cada frame
		contador_tempo += 1 * (delta_time / 100000);

		// Verifica se o tempo de espera foi atingido
		if (contador_tempo >= tempo_espera) {
		    // Soltar o ovo na posição da galinha
		    instance_create_layer(x, y, layer, obj_ovo);  // Cria o ovo na mesma posição da galinha
    
		    // Reseta o contador para o próximo ovo
		    contador_tempo = 0;
		}
	
		if (contador_tempo >= canto) {
			//audio_play_sound_at(GalinhaSFX, x, y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
			canto = random_range(70, 300);
		
			contador_tempo = 0;
		}
	}

	fome = max(0, fome-1);
	alerta = min(100, alerta+1);

	if (alerta == 100) {
		alerta = 0;
	}

	// coisas n dependentes do player:
	if (World.time > 18 && World.time < 24 || World.time > 0 && World.time < 5) {
		sono = min(100, sono+1);
	}
	else {
		sono = max(0, sono-1);
	}
}