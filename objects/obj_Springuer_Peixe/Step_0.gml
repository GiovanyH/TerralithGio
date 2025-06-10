if (instance_exists(obj_Player)) {
	if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {
		image_angle = 0;

		dir_x = perlin_noise(swim_perlin_noisex);
		dir_y = perlin_noise(swim_perlin_noisey);

		if (move_and_collide(move_x, move_y, tilemap) != undefined) {
			move_y = lerp(move_y, dir_y * move_speed, 0.1);
			move_x = lerp(move_x, dir_x * move_speed, 0.1);
	
			move_y += self_gravity;
	
			look_at(move_x, move_y);
			sprite_index = Springuer_Walk_spr;
	
			if ((tilemap_get(water_tilemap, x / 16, y / 16) == 6 || tilemap_get(water_tilemap, x / 16, y / 16) == 7) && dir_y < 0) {
				move_y -= 20;
			}
	
			if (tilemap_get(water_tilemap, x / 16, y / 16) != 14 && tilemap_get(water_tilemap, x / 16, y / 16) != 15) {
				self_gravity = 1.0;
			}
			else {
				self_gravity = 0.0;
			}
		}

		swim_perlin_noisex += inc;
		swim_perlin_noisey += inc;
	}
}