// Feito por Giovany
function get_player_pos() {
	if (instance_exists(obj_Player)) {
		return new vector(obj_Player.x, obj_Player.y);
	}
	return new vector(0, 0);
}