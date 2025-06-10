var div_delta_time = delta_time / 100000;
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

layer_x("Backgrounds_1", _cam_x * 0.75);
layer_x("Backgrounds_4", _cam_x * 0.75);
layer_x("Backgrounds_2", _cam_x * 0.5);
layer_x("Backgrounds_3", _cam_x * 0.25);

layer_y("Backgrounds_1", _cam_y * 0.75);
layer_y("Backgrounds_4", _cam_y * 0.75);
layer_y("Backgrounds_2", _cam_y * 0.5);
layer_y("Backgrounds_3", _cam_y * 0.25);

var time_constant = 0.003 * time_multiplier; // test

var almost_morning_col = [0.33, 0.33, 0.9, 1.0];
var morning_col = [0.7, 0.9, 1.0, 1.0];
var midday_col = [1.0, 1.0, 1.0, 1.0];
var lateday_col = [1.0, 0.7, 0.6, 1.0];
var almost_night_col = [0.7, 0.33, 0.33, 1.0];
var night_col = [0.05, 0.03, 0.1, 1.0];
var mid_night_col = [0.01, 0.01, 0.15, 1.0];

// time of day thing
if (time > 5 && time < 6) {
	current_col = lerp_col(current_col, morning_col, time_constant * 3.0);
}
else if (time > 10 && time < 12) {
	current_col = lerp_col(current_col, midday_col, time_constant * 1.5);
}
else if (time > 14 && time < 16) {
	current_col = lerp_col(current_col, lateday_col, time_constant * 1.5);
}
else if (time > 17 && time < 18) {
	current_col = lerp_col(current_col, almost_night_col, time_constant * 3.0);
}
else if (time > 18 && time < 20) {
	current_col = lerp_col(current_col, night_col, time_constant * 1.5);
}
else if (time > 20 && time < 24) {
	current_col = lerp_col(current_col, mid_night_col, time_constant);
}
else if (time > 4 && time < 5) {
	current_col = lerp_col(current_col, almost_morning_col, time_constant * 3.0);
}

var _fx_struct = layer_get_fx("Effect_3");

if (_fx_struct != -1)
{
    var _params = fx_get_parameters(_fx_struct);
    var _osc = sin(current_time / 1000);
    _params.g_TintCol = current_col;

    fx_set_parameters(_fx_struct, _params);
}

var _fx_screenshake = layer_get_fx("ScreenShake");

if (_fx_screenshake != -1)
{
	var _params = fx_get_parameters(_fx_screenshake);
	_params.g_ShakeSpeed = lerp(_params.g_ShakeSpeed, 0.0, 0.1);

	fx_set_parameters(_fx_screenshake, _params);
}

var _fx_particles = layer_get_fx("Effect_7");

if (_fx_particles != -1)
{
	var _params = fx_get_parameters(_fx_particles);
	_params.param_sprite = current_part_sprite;
	
	fx_set_parameters(_fx_particles, _params);
}

if (keyboard_check(ord("M"))) {
	zoom_level = 20.0;
}
else {
	zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.5, 2);
}

new_w = lerp(view_w, zoom_level * default_zoom_width, 0.2);
new_h = lerp(view_h, zoom_level * default_zoom_height, 0.2);

camera_set_view_size(view_camera[0], new_w, new_h);

current_biome = get_biome(temperature_map[floor(get_player_pos().x / 16)], humidity_map[floor(get_player_pos().x / 16)]);

if (current_biome >= -0.5 && current_biome < 0.5) {
	layer_background_sprite(background_1, TerraBack3_spr);
	layer_background_sprite(background_2, TerraBack2_spr);
	layer_background_sprite(background_3, TerraBack1_spr);
	
	current_part_sprite = Folha;
}
else if (current_biome >= 0.5 && current_biome <= 1.5) {
	layer_background_sprite(background_1, AreiaBack3_spr);
	layer_background_sprite(background_2, AreiaBack2_spr);
	layer_background_sprite(background_3, AreiaBack3_spr);
	
	current_part_sprite = PartDeserto;
}
else if (current_biome > 1.5 && current_biome <= 2.5) {
	layer_background_sprite(background_1, NeveBack1_spr_1);
	layer_background_sprite(background_2, NeveBack2_spr_1);
	layer_background_sprite(background_3, NeveBack3_spr_1);
	
	current_part_sprite = FlocosdNeve;
}
else {
	layer_background_sprite(background_1, AreiaBack3_spr);
	layer_background_sprite(background_2, AreiaBack2_spr);
	layer_background_sprite(background_3, AreiaBack3_spr);
	
	current_part_sprite = PartDeserto;
}

var next_biome = round(current_biome);

var opacity_bg = (1 / abs(next_biome - current_biome)) / 5.0;

if (keyboard_check_pressed(ord("T"))) {
	show_message(opacity_bg);
	show_message(next_biome);
	show_message(current_biome);
}

shader_set(background_transition);

layer_shader("Backgrounds_1", background_transition);
shader_set_uniform_f(shader_get_uniform(background_transition, "opacity"), opacity_bg);

layer_shader("Backgrounds_4", background_transition);
shader_set_uniform_f(shader_get_uniform(background_transition, "opacity"), opacity_bg);

layer_shader("Backgrounds_2", background_transition);
shader_set_uniform_f(shader_get_uniform(background_transition, "opacity"), opacity_bg);

layer_shader("Backgrounds_3", background_transition);
shader_set_uniform_f(shader_get_uniform(background_transition, "opacity"), opacity_bg);

shader_reset();

audio_listener_position(get_player_pos().x, get_player_pos().y, 0);
audio_listener_orientation(0, 0, 1000, 0, -1, 0);

function update_block_pos() {
	var block_pos = raycast_tiles(get_player_pos().x, get_player_pos().y, mouse_x, mouse_y, tilemap);
    
    if (block_pos != noone) {
        // Calculate tile coordinates of the collided tile
        var tile_x = block_pos[0] div 16;
        var tile_y = block_pos[1] div 16;

        // Get the center of the collided tile
        var tile_center_x = tile_x * 16 + 8; // Center X of the tile
        var tile_center_y = tile_y * 16 + 8; // Center Y of the tile

        // Determine the side of the collision
        var offset_x = 0;
        var offset_y = 0;

        // Calculate distance from the center to the hit position
        var dist_x = block_pos[0] - tile_center_x;
        var dist_y = block_pos[1] - tile_center_y;

        // Determine side based on smallest distance
        if (abs(dist_x) > abs(dist_y)) {
            // Horizontal hit
            if (dist_x < 0) {
                // Hit the left side
                offset_x = -1; // Place the block to the left
            } else {
                // Hit the right side
                offset_x = 1; // Place the block to the right
            }
            offset_y = 0; // No vertical offset
        } else {
            // Vertical hit
            if (dist_y < 0) {
                // Hit the top side
                offset_y = -1; // Place the block above
            } else {
                // Hit the bottom side
                offset_y = 1; // Place the block below
            }
            offset_x = 0; // No horizontal offset
        }

        // Add the block at the calculated position
		return [tile_x + offset_x, tile_y + offset_y];
    }
	
	return [0, 0];
}

// block resolve
if (!blocks_resolved) {
	for (var i = 0; i < world_sizex; i++) {
		for (var i2 = floor(height_map[i]); i2 < world_sizey; i2++) {
			resolve_block(i, i2 + 1);
		}
	}
	
	blocks_resolved = true;
}

block_put_x = update_block_pos()[0];
block_put_y = update_block_pos()[1];

if (mouse_check_button_pressed(mb_right)) {
	var block_pos = update_block_pos();
	add_block(block_pos[0], block_pos[1], 5); 
}


if (mouse_check_button(mb_left) && tilemap_get(tilemap, mouse_x div 16, mouse_y div 16) != 0 && instance_exists(brocu_quebra_ins)) {
	brocu_quebra_ins.x = floor(mouse_x div 16) * 16;
	brocu_quebra_ins.y = floor(mouse_y div 16) * 16;
	brocu_quebra_ins.image_speed = 1;
	if (elapsed_mining_time >= block_mining_time) {
		remove_block(mouse_x div 16, mouse_y div 16);
		update_lightmap();
		elapsed_mining_time = 0.0;
		brocu_quebra_ins.image_speed = 0;
		brocu_quebra_ins.image_index = 0;
		brocu_quebra_ins.x = 0;
		brocu_quebra_ins.y = 0;
	}
	
	elapsed_mining_time += div_delta_time;
}
else {
	if (instance_exists(brocu_quebra_ins)) {
		elapsed_mining_time = 0.0;
		brocu_quebra_ins.image_speed = 0;
		brocu_quebra_ins.image_index = 0;
	
		brocu_quebra_ins.x = 0;
		brocu_quebra_ins.y = 0;
	}
}

var player_position_x = ceil((get_player_pos().x) div 16);
var player_position_y = ceil((get_player_pos().y) div 16);

var is_player_on_water = tilemap_get(water_tilemap, player_position_x, player_position_y) == 7;
var is_player_under_water = tilemap_get(water_tilemap, player_position_x, player_position_y) == 15;

function tibum() {
	var tibuns = [Tibum1, Tibum2];
	var tibum_index = irandom_range(0, 1);
	part_particles_burst(ps, get_player_pos().x, get_player_pos().y, TibumPart);
	audio_sound_pitch(Tibum1, random_range(0.75, 1.25));
	audio_sound_pitch(Tibum2, random_range(0.75, 1.25));
	audio_play_sound_at(tibuns[tibum_index], get_player_pos().x, get_player_pos().y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
}

if (instance_exists(obj_Player)) {
	if (!obj_Player.is_on_water && !obj_Player.is_under_water) {
		player_wasnt_on_water = true;
	}
	else if (player_wasnt_on_water) {
		tibum();
		player_wasnt_on_water = false;
	}
	

	obj_Player.is_on_water = is_player_on_water;
	obj_Player.is_under_water = is_player_under_water;
	
	if (is_player_on_water && obj_Player.dir_y < 0) {
		obj_Player.move_y -= 5;
		audio_sound_pitch(Tibum3, random_range(0.75, 1.25));
		audio_play_sound_at(Tibum3, obj_Player.x, obj_Player.y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
	}
}

if (time >= 24) {
	time = 0;
}
time += delta_time / 3000000 * time_multiplier;