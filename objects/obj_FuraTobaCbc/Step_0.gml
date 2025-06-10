if (instance_find(obj_Player, 0)) {
	player_position[0] = obj_Player.x;
	player_position[1] = obj_Player.y;
}

if (instance_exists(obj_FuraToba) && !obj_FuraToba.following) {
	look_at(player_position[0], player_position[1]);
}