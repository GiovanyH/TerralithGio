dir_x = key_right() - key_left();
dir_y = key_down() - key_up();

function reset_inv_pos() {
	GUI.unlerped_inv_y_offset = 0.0;
	GUI.elapsed_time = 0;
}

// Placeholder
if (keyboard_check_pressed(ord("1"))) {
	current_inv_index = 0;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}
else if (keyboard_check_pressed(ord("2"))) {
	current_inv_index = 1;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}
else if (keyboard_check_pressed(ord("3"))) {
	current_inv_index = 2;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}
else if (keyboard_check_pressed(ord("4"))) {
	current_inv_index = 3;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}
else if (keyboard_check_pressed(ord("5"))) {
	current_inv_index = 4;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}
else if (keyboard_check_pressed(ord("6"))) {
	current_inv_index = 5;
	audio_sound_pitch(InventoryInteract, random_range(0.5, 1.5));
	audio_play_sound(InventoryInteract, 10, false);
	reset_inv_pos();
}

if (keyboard_check_pressed(ord("Q"))) {
	drop_item(current_inv_index, 0, ds_map_find_value(item_map, player_inventory[0][current_inv_index][0])[1], current_weapon);
}

current_weapon = player_inventory[0][current_inv_index][0];

if (keyboard_check_pressed(ord("E"))) {
	is_attacking = true;
}

current_block = tilemap_get(tilemap, GUI.mouse_position.x / 16, GUI.mouse_position.y / 16);

switch (current_block) {
	case 40:
	case 41:
	case 42:
	case 52:
	case 2:
	case 3:
	case 4:
	case 6:
		block_mining = "Dirt";
		break;
	case 19:
	case 20:
	case 21:
	case 28:
		block_mining = "Sand";
		break;
	case 49:
	case 50:
	case 57:
	case 58:
	case 30:
	case 31:
		block_mining = "Rock";
		break;
	case 38:
	case 39:
		block_mining = "Wood";
		break;
}

function mine_block(tilemap_id, pos_x, pos_y, sprite, name) {
	tilemap_set(tilemap, 0, pos_x, pos_y);
	elapsed_mining = 0.0;
	
	drop_item(pos_x * 16, pos_y * 16, sprite, name);
}

if (mouse_check_button(mb_left)) {
	var sprite = BlocoGramaGui_spr;
	switch (block_mining) {
		case "Dirt":
			if (current_weapon == "Shovel") block_mining_time = 2.0;
			else block_mining_time = 8.0;
			sprite = BlocoGramaGui_spr;
			break;
		case "Sand":
			if (current_weapon == "Shovel") block_mining_time = 2.0;
			else block_mining_time = 8.0;
			sprite = BlocoAreia_Gui_spr;
			break;
		case "Rock":
			if (current_weapon == "Pick") block_mining_time = 8.0;
			else block_mining_time = 20.0;
			sprite = BlocoPedraGui_spr;
			break;
		case "Wood":
			if (current_weapon == "Axe") block_mining_time = 8.0;
			else block_mining_time = 20.0;
			sprite = BlocoMadeiraNormal_spr;
			break;
	}
	if (elapsed_mining > block_mining_time) {
		mine_block(tilemap, GUI.mouse_position.x / 16, GUI.mouse_position.y / 16, sprite, block_mining); 
	}
	elapsed_mining += (delta_time / 600000);
}
else {
	elapsed_mining = 0.0;
}

load_up_sprites(current_weapon);

if (is_dead) {
	image_angle = 0;
	sprite_index = PlayerMorte_spr;
}
else if (taking_damage) {
	image_angle = 0;
	sprite_index = PlayerDamage_spr;
	move_and_collide(move_x, move_y, tilemap);
}
else if (is_under_water) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * MOVE_SPEED, AIR_DRAGGING);
		move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);
	
		look_at(move_x, move_y);
		sprite_index = water_sprites[0];
	}
}
else if (is_on_water) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * MOVE_SPEED, AIR_DRAGGING);
		move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);
	}
	sprite_index = water_sprites[0];
}
else if (is_attacking) {
}
else {
	
	image_angle = 0;
	
	if (on_floor_p()) {
		if (dir_x != 0) {
			sprite_index = floor_sprites[1];
		}

		else {
			sprite_index = floor_sprites[0];
		}
	}
	else {
		if (move_y > 0) {
			sprite_index = floor_sprites[3];
		}
		else {
			sprite_index = floor_sprites[2];
		}
	}
	
	move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);

	if (on_floor_p()) {
		AIR_DRAGGING = 1.0;
		can_double_jump = false;
	}
	else {
		AIR_DRAGGING = 0.1;
		if (move_y < 10.0) {
			move_y += GRAVITY_SPEED * delta_time / 1000000;
		}
		on_floor_hm = false;
	}

	if (key_up_pressed()) {
		jump();
	}

	if (on_floor_p() && move_y > 0.0) {
		move_y = 0.0;
	}

	if (on_ceiling() && move_y < 0.0) {
		move_y = 0.0;
	}

	if (dir_x < 0) {
		image_xscale = -1;
	}
	else if (dir_x > 0) {
		image_xscale = 1;
	}

	if (just_landed && on_floor_p()) {
		audio_sound_pitch(Dirt_Fall, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Fall, 10, false);
		just_landed = false;
	}
	
	move_and_collide(move_x, move_y, tilemap);
}

if (y > 5000) kill_self();

if (elapsed_time >= rand_time) {
	play_music();
	elapsed_time = 0;
	rand_time = random_range(150, 200);
}

function get_supposed_ambient() {
	if (!instance_exists(World)) return forest_morning;
	var supposed_ambient = forest_morning;
	
	if (World.time > 5 && World.time < 11) {
		supposed_ambient = forest_morning;
	}
	else if (World.time > 12 && World.time < 17) {
		supposed_ambient = forest_late;
	}
	else if (World.time > 19 && World.time < 24 || World.time > 0 && World.time < 4) {
		supposed_ambient = forest_night;
	}
	
	return supposed_ambient;
}

if (get_supposed_ambient() != current_ambients[1]) {
	audio_stop_sound(current_ambients[1]);
	audio_stop_sound(current_ambients[0]);
	current_ambients[1] = get_supposed_ambient();
	audio_play_sound(current_ambients[0], 2, true);
	audio_play_sound(current_ambients[1], 1, true);
}

function damage() {
	if (damage_cooldown > 10) {
		sprite_index = PlayerDamage_spr;
		part_particles_burst(ps, x, y, Damage);
		audio_sound_pitch(DamageSFX, random_range(0.75, 1.25));
	    audio_play_sound(DamageSFX, 10, false);
		
		taking_damage = true;
			
		decrease_health(20);
		damage_cooldown = 0.0;
	}
}

damage_cooldown += delta_time / 100000;

elapsed_time += delta_time / 1000000;


