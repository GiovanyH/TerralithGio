move_y = gravity_speed;

// Calcula a velocidade com Perlin Noise
var dir_x = map_value(perlin_noise(move_perlin_noise), -1.0, 1.0, -1.0, 1.0);

// Modifica o fator de interpolação para algo mais perceptível
move_x = lerp(move_x, dir_x, 0.1) * (room_speed / 60);  // Aqui aumentei o fator e o valor de interpolação

// Verifica colisão com o chão e executa pulo se estiver em movimento
if (place_meeting(x + 2.0, y, floor_tilemap) && move_x != 0) {
    jump();
}

if (on_floor()) {
	sprite_index = Sprite13;
}
else {
	sprite_index = NpcPescadorJump;
}

if (dir_x < 0) {
	image_xscale = -1;
}
else if (dir_x > 0) {
	image_xscale = 1;
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

// Aplica o movimento e a colisão
move_and_collide(move_x, move_y, floor_tilemap);
