move_x = 0.00;
move_y = 0.00;

dir_x = 0;

gravity_speed = 1.0;

move_perlin_noise = random(3000);

floor_tilemap = layer_tilemap_get_id("Tiles_1");

function on_floor() {
	return place_meeting(x, y + 2.0, floor_tilemap);
}

function jump() {
	move_y = 0;
	move_y -= 3;
}