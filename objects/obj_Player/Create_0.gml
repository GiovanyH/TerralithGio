// Constants, sort of
MOVE_SPEED = 1.75;
GRAVITY_SPEED = 16.0;
AIR_DRAGGING = 1.0; // Disabled when on floor
JUMP_HEIGHT = 5;

MAX_BAR_LEVEL = 100;
OXYGEN_LEVEL = 100;
HEALTH_LEVEL = 100;

// Definitions

// SFX
footstep_sounds = [Dirt_01, Dirt_02];
nadando_sounds = [Nadando1, Nadando2];
musicas = [Musicar, Musicartrister, butt, Musicar__1_, Musicar__2_, Project_15];

forest_ambients = [forest_all, forest_morning, forest_late, forest_night];
current_ambients = [forest_all, forest_morning];

// Sprites
floor_sprites = [FarmerIdle_spr, FarmerRun_spr, FarmerJump_spr, FarmerFall_spr, SwordFarmerAttack_spr];
water_sprites = [FarmerNadando_spr];
attack_obj = instance_create_layer(x, y, 0, AttackObj);

damage_cooldown = 0.0;

elapsed_mining = 0.0;
block_mining_time = 5.0;

block_mining = "Dirt";

current_block = 0;

// Helper functions
function get_floor_layer() {
	if (layer_exists("FloorTile")) {
		return layer_tilemap_get_id("FloorTile");
	}
	else {
		return layer_tilemap_get_id("Tiles_1");
	}
}

function get_decoration_layer() {
}

function get_spawn_point() {
	if (instance_exists(obj_SpawnPoint)) {
		return instance_find(obj_SpawnPoint, 0);
	}
	return noone;
}

function key_left() {
	return keyboard_check(vk_left) || keyboard_check(ord("A"));
}

function key_right() {
	return keyboard_check(vk_right) || keyboard_check(ord("D"));
}

function key_up_pressed() {
	return keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
}

function key_up() {
	return keyboard_check(vk_up) || keyboard_check(ord("W"));
}

function key_down() {
	return keyboard_check(vk_down) || keyboard_check(ord("S"));
}

function load_up_sprites(current_weapon) {
	if (current_weapon == "None") {
		floor_sprites = [FarmerIdle_spr, FarmerRun_spr, FarmerJump_spr, FarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Axe") {
		floor_sprites = [AxeFarmerIdle_spr, AxeFarmerRun_spr, AxeFarmerJump_spr, AxeFarmerFall_spr, AxeFarmerAttack_spr];
	}
	else if (current_weapon == "Sword") {
		floor_sprites = [SwordFarmerIdle_spr, SwordFarmerRun_spr, SwordFarmerJump_spr, SwordFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Shovel") {
		floor_sprites = [ShovelFarmerIdle_spr, ShovelFarmerRun_spr, ShovelFarmerJump_spr, ShovelFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Fork") {
		floor_sprites = [ForkFarmerIdle_spr, ForkFarmerRun_spr, ForkFarmerJump_spr, ForkFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Rod") {
		floor_sprites = [RodFarmerIdle_spr, RodFarmerRun_spr, RodFarmerJump_spr, RodFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Light") {
		floor_sprites = [LightFarmerIdle_spr, LightFarmerRun_spr, LightFarmerJump_spr, LightFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Wood") {
		floor_sprites = [FarmerItemIdle_spr, FarmerItemRun_spr, FarmerItemJump_spr, FarmerItemFall_spr, SwordFarmerAttack_spr];
	}
}

tilemap = get_floor_layer();
tilemap2 = layer_tilemap_get_id("Tiles_3");
ps = get_effects_layer();

spawn_point = get_spawn_point();

move_x = 0.0;
move_y = 0.0;
previous_x = 0.0;
previous_y = 0.0;
dir_x = 0;
dir_y = 0;
rotation = 0.0;

// States
can_double_jump = false;
is_dead = false;
on_floor_hm = false;
just_landed = false;
is_attacking = false;
is_dead = false;
taking_damage = false;

is_on_water = false;
is_under_water = false;

current_inv_index = 0;

item_map = ds_map_create();
ds_map_add(item_map, "None", ["None", noone, 1, 0, 0]);
ds_map_add(item_map, "Axe", ["Axe", Machado_spr, 1, 0, 0]);
ds_map_add(item_map, "Sword", ["Sword", Espada_spr, 1, 0, 0]);
ds_map_add(item_map, "Fork", ["Fork", Garfo_spr, 1, 0, 0]);
ds_map_add(item_map, "Shovel", ["Shovel", Pa_spr, 1, 0, 0]);
ds_map_add(item_map, "Rod", ["Rod", Vara_spr, 1, 0, 0]);
ds_map_add(item_map, "Wood", ["Wood", MadeiraBasica_spr, 16, -8, -8]);
ds_map_add(item_map, "Dirt", ["Dirt", BlocoGramaGui_spr, 16, -8, -8]);
ds_map_add(item_map, "Sand", ["Sand", BlocoAreia_Gui_spr, 16, -8, -8]);
ds_map_add(item_map, "Rock", ["Rock", BlocoPedraGui_spr, 16, -8, -8]);

item = ["None", noone, 1];

player_inventory = array_create(3, []);
player_inventory[0] = [["None", noone, 1], ["Axe", Machado_spr, 1], ["Sword", Espada_spr, 1], ["Fork", Garfo_spr, 1], ["Shovel", Pa_spr, 1], ["Rod", Vara_spr, 1]];
player_inventory[1] = [["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1]];
player_inventory[2] = [["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1], ["None", noone, 1]];

current_weapon = "None";

// Timing
rand_time = 0;
elapsed_time = 0.0;
image_speed = 1;
number = 0;

function find_inv_empty_index() {
	for (var j = 0; j < array_length(player_inventory); j++) {
		for (var i = 0; i < array_length(player_inventory[j]); i++) {
			if (player_inventory[j][i][0] == "None") return new vector(i, j);
		}
	}
	return new vector(-1, -1);
}

function find_existing_item_in_inventory(name) {
	for (var j = 0; j < array_length(player_inventory); j++) {
		for (var i = 0; i < array_length(player_inventory[j]); i++) {
			if (player_inventory[j][i][0] == name && player_inventory[j][i][2] < ds_map_find_value(item_map, player_inventory[j][i][0])[2]) return new vector(i, j);
		}
	}
	return new vector(-1, -1);
}

function drop_item(i, j, sprite, name) {
	var item_dropped = instance_create_layer(x, y, "Instances", DropItem);
	
	item_dropped.current_sprite = sprite;
	item_dropped.item_name = name;
}

function collect_item(name) {
	player_inventory = obj_Player.player_inventory;
	var current_item = ds_map_find_value(item_map, name);
	var item_slot_support = current_item[2];
	var existing_item = find_existing_item_in_inventory(name);
	if (existing_item.x == -1) {
		existing_item = find_inv_empty_index();
	}
	
	if (existing_item.x == -1) return -1;
	
	if (player_inventory[existing_item.y][existing_item.x][0] == name) player_inventory[existing_item.y][existing_item.x][2] += 1;
	else {
		player_inventory[existing_item.y][existing_item.x][0] = name;
		player_inventory[existing_item.y][existing_item.x][1] = current_item[1];
		player_inventory[existing_item.y][existing_item.x][2] = 1;
	}
	
	return 0;
}

function on_floor_p() {
	if (on_floor_hm == false) just_landed = true;
	on_floor_hm = true;
	return on_floor(tilemap);
}

function on_ceiling() {
	return place_meeting(x, y - 2.0, tilemap);
}

function jump() {
	if (on_floor_p()) {
		move_y = 0;
		move_y -= JUMP_HEIGHT;
		can_double_jump = true;
		audio_sound_pitch(Dirt_Jump, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Jump, 10, false);
	}
	else {
		if (can_double_jump) {
			move_y = 0;
			move_y -= JUMP_HEIGHT;
			can_double_jump = false;
			part_particles_burst(ps, x, y, JumpParticle);
			audio_play_sound(DoubleJump, 10, false);
		}
	}
}

function die() {
	is_dead = true;
}

function increase_oxygen(amount) {
	if (OXYGEN_LEVEL + amount >= MAX_BAR_LEVEL) OXYGEN_LEVEL = MAX_BAR_LEVEL;
	else OXYGEN_LEVEL += amount;
}

function decrease_health(amount) {
	if (HEALTH_LEVEL > 0) HEALTH_LEVEL -= amount;
	else {
		HEALTH_LEVEL = 0;
		
		die();
	}
}

function decrease_oxygen(amount) {
	if (OXYGEN_LEVEL + amount >= 0) OXYGEN_LEVEL -= amount;
	else {
		OXYGEN_LEVEL = 0;
		
		decrease_health(10);
	}
}

function kill_self() {
    game_restart();
}

function look_at(target_x, target_y) {
    var angle = point_direction(0, 0, target_x, target_y);
    
    image_angle = angle - 90;
}

randomize();

function play_music() {
	audio_play_sound(musicas[irandom_range(0, array_length(musicas) - 1)], 0, false);
}

window_set_cursor(cr_none);
load_up_sprites(current_weapon);


