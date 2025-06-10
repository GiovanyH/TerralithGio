if (following) {
	move_x += dir_vect.x * velocity;
	move_y += dir_vect.y * velocity;
	
	if (distance_to_point(old_pos.x, old_pos.y) > max_distance) {
		following = false;
	}
}

if (current_wait_time >= wait_time) {
	following = true;
	old_pos.x = x;
	old_pos.y = y;
	
	if (instance_exists(obj_Player)) {
		pos_to_follow.x = obj_Player.x;
		pos_to_follow.y = obj_Player.y;
	}
	
	dir_vect = new vector(pos_to_follow.x - x, pos_to_follow.y - y);
	dir_vect.normalize();
	
	current_wait_time = 0; // reset
}

if (instance_exists(obj_Player) && distance_to_object(obj_Player) < 10.0) {
	obj_Player.damage();
}

cabeca.x = x;
cabeca.y = y;

x = lerp(x, move_x, 0.1);
y = lerp(y, move_y, 0.1);

current_wait_time += delta_time / 100000;