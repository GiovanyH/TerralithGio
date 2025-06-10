if (instance_exists(obj_Player)) {
	if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {
		image_angle = 0;

		dir_x = perlin_noise(air_perlin_noisex);
		dir_y = perlin_noise(air_perlin_noisey);

		if (move_and_collide(move_x, move_y, tilemap) != undefined) {
			if (!place_meeting(x, y + 100.0, tilemap)) move_y = lerp(move_y, dir_y * move_speed, 0.1);
			move_x = lerp(move_x, dir_x * move_speed, 0.1);
	
			look_at(move_x, move_y);
			sprite_index = Pomkuku_Flyspr;
		}

		air_perlin_noisex += inc;
		air_perlin_noisey += inc / 2.0;
	}
}