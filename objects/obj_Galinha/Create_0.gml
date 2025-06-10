move_x = 0.00;
move_y = 0.00;

y_force_amount = 0.0;

overlayed_direction = 1.0;
dir_x = 0.0;
gravity_speed = 1.0;
move_perlin_noise = random(3000);
floor_tilemap = layer_tilemap_get_id("Tiles_1");
current_bioma = 0;

speed_amount = 64.0; // 64 pixels por segundo

// necessidades:
sono = 100.0;
agrupamento = 0.0;
fome = 50.0;
alerta = 50.0;
medo = 0.0;

satisfacao = 50.0;

vontade_de_explorar = 1;

function jump() {
	y_force_amount = -25;
}
// Create Event da galinha (Object9)

// Definir tempo em segundos 
tempo_espera = 180 * room_speed;  // room_speed define o número de frames por segundo (fps)
canto = random_range(0, 200);

// Iniciar o contador de tempo
contador_tempo = 0;