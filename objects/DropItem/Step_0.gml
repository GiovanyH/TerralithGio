if (on_floor(floor_tilemap)) move_y = 0;
else move_y = GRAVITY_CONSTANT;

move_x = IMPULSO_X;

IMPULSO_X = lerp(IMPULSO_X, 0.0, 0.1);

smooth_time += delta_time / 100000;
collect_cooldown += delta_time / 100000;

spriteoffsetx = lerp(spriteoffsetx, cos(smooth_time) * 3, 0.2);
spriteoffsety = lerp(spriteoffsety, sin(smooth_time) * 3, 0.2);

if (instance_exists(obj_Player)) {
	if (distance_to_object(obj_Player) < 5.0) {
		if (collect_cooldown > 10) {
			collect();
		}
	}
}

move_and_collide(move_x, move_y, floor_tilemap);