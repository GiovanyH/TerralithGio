if (instance_exists(obj_Player)) {
	x = obj_Player.x;
	y = obj_Player.y;

	if (obj_Player.is_attacking) {
		if (obj_Player.current_weapon == "Sword" || obj_Player.current_weapon == "Axe") {
			image_speed = 1;
			image_xscale = obj_Player.image_xscale;
		}
		else {
			obj_Player.is_attacking = false;
		}
	}
	else {
		image_speed = 0;
		image_index = 0;
	}
}