_cam_x = camera_get_view_x(view_camera[0]);
_cam_y = camera_get_view_y(view_camera[0]);

view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

var current_selected = 0;

inv_y_offset = lerp(inv_y_offset, unlerped_inv_y_offset, 0.1);

var inv_x = (_cam_x + (view_w * 0.5) - 160) + 11;
var current_inv_y = _cam_y + (view_h * 0.75);
var inv_y = current_inv_y; // a

var bar_width = 32;
var bar_pos = _cam_x + (view_w * 0.1);

mouse_pos.x = window_mouse_get_delta_x();
mouse_pos.y = window_mouse_get_delta_y();

function point_inside_square(point_x, point_y, square_x, square_y, square_size) {
	
}

if (instance_exists(obj_Player)) {
	player_oldpos.x = player_pos.x;
	player_oldpos.y = player_pos.y;
	player_pos.x = obj_Player.x;
	player_pos.y = obj_Player.y;
	
	player_vel = vector_subtract(player_pos, player_oldpos);
	
	if (keyboard_check_pressed(ord("L"))) {
		current_mouse_pos.x = obj_Player.x;
		current_mouse_pos.y = obj_Player.y;
	}
	
	if (point_distance(current_mouse_pos.x + mouse_pos.x, current_mouse_pos.y + mouse_pos.y, obj_Player.x, obj_Player.y) < 100.0) {
		current_mouse_pos.x += mouse_pos.x;
		current_mouse_pos.y += mouse_pos.y;
	}
	else {
		draw_circle(obj_Player.x, obj_Player.y, 100, true);
	}
	
	current_mouse_pos.x += player_vel.x;
	current_mouse_pos.y += player_vel.y;
	
	draw_sprite_stretched(HealthBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4, bar_width * (obj_Player.HEALTH_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25));

	draw_sprite_stretched(OxigenBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4 + 32,  bar_width * (obj_Player.OXYGEN_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25) + 32);
	
	var middle_screen_x = _cam_x + (view_w * 0.5);
	var middle_screen_y = _cam_y + (view_h * 0.5);
	
	var inv_grid_size = 22;
	
	var inv_size_x = inv_grid_size * 6;
	var inv_size_y = inv_grid_size * 3;
	
	if (show_inventory) {
		current_cursor = Rato_spr;
		draw_sprite(InventoryBlueprint_spr, -101, (floor((middle_screen_x - (inv_size_x * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), (floor((middle_screen_y - (inv_size_y * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5));
		
		var inventory = obj_Player.player_inventory;
		
		mouse_position.x = (floor(current_mouse_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5);
		mouse_position.y = (floor(current_mouse_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5);
		
		if (mouse_clicked && held_item[1] != noone) {
			if (mouse_position.x < middle_screen_x - (inv_size_x * 0.6) || mouse_position.x > middle_screen_x + (inv_size_x * 0.5)) {
				obj_Player.drop_item(held_pos.x, held_pos.y, currently_selected, selected_name);
				held_item = ["None", noone, 1];
						
				mouse_clicked = false;
			}
		}
		
		for (var i = 0; i < 6; i++) {
			for (var j = 0; j < 3; j++) {
				var slot_pos = new vector(middle_screen_x - (inv_size_x * 0.5) + (i * inv_grid_size), middle_screen_y - (inv_size_y * 0.5) + (j * inv_grid_size));
				if (!(mouse_position.x == ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) && mouse_position.y == ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)))) {
				}
				else {
					draw_sprite(Selection, -105, ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - i, ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - j);
					if (mouse_clicked) {
						if (held_item[1] == noone) {
							held_item = obj_Player.player_inventory[j][i];
							held_pos.x = i;
							held_pos.y = j;
							obj_Player.player_inventory[j][i] = ["None", noone, 1];
						}
						else {
							if (obj_Player.player_inventory[j][i][0] == "None") {
								obj_Player.player_inventory[j][i] = held_item;
								held_item = ["None", noone, 1];
							}
							else { // Item Swap
								obj_Player.player_inventory[held_pos.y, held_pos.x] = obj_Player.player_inventory[j][i];
								obj_Player.player_inventory[j][i] = held_item;
								held_item = ["None", noone, 1];
							}
						}
						
						mouse_clicked = false;
					}
				}
				
				if (inventory[j][i][0] != "None") {
					item_offset.x = ds_map_find_value(obj_Player.item_map, inventory[j][i][0])[3];
					item_offset.y = ds_map_find_value(obj_Player.item_map, inventory[j][i][0])[4];
					if (inventory[j][i][1] == MadeiraBasica_spr) draw_sprite(inventory[j][i][1], -103, (((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + inv_grid_size) - i) - 8, (((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size + 1)) - j) - 8);
					else draw_sprite(inventory[j][i][1], -103, (((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + inv_grid_size) - i) + item_offset.x, (((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size + 1)) - j) + item_offset.y);
					
					draw_set_font(InvFont);
					draw_text(((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + inv_grid_size) - i, ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size + 1)) - j, inventory[j][i][2]);
					draw_set_font(MainMenuFont);
				}
				else {
					item_offset.x = 0;
					item_offset.y = 0;
				}
				if (held_item[1] != noone) {
					draw_sprite(held_item[1], -104, mouse_position.x, mouse_position.y);
				}
			}
		}
	}
	else {
		current_cursor = RealCursor;
		mouse_position.x = (floor(current_mouse_pos.x / 16) * 16) + 8;
		mouse_position.y = (floor(current_mouse_pos.y / 16) * 16) + 8;
	}
	
	if (!show_inventory) draw_sprite(Cursor, -103, mouse_position.x, mouse_position.y);

	draw_sprite(Gui_Inventario_spr, -100, _cam_x + ((view_w * 0.5) - 160), inv_y + inv_y_offset);
	draw_sprite(Gui_Selected, -101, inv_x + (50 * obj_Player.current_inv_index), inv_y + inv_y_offset);
	
	for (var i = 0; i < 6; i++) {
		var item_x = inv_x + (50 * i) + 24;
		var item_y = inv_y + 26 + inv_y_offset;
		
		var current_sprite = obj_Player.player_inventory[0][i][1];
		
		item_offset.x = ds_map_find_value(obj_Player.item_map,obj_Player.player_inventory[0][i][0])[3];
		item_offset.y = ds_map_find_value(obj_Player.item_map, obj_Player.player_inventory[0][i][0])[4];
		
		if (current_sprite != noone) draw_sprite(current_sprite, -102, item_x + item_offset.x, item_y + item_offset.y);
	}
}
else {
	current_mouse_pos.x = mouse_x;
	current_mouse_pos.y = mouse_y;
}

if (show_pause_menu) {
	instance_deactivate_layer("Instances");
	instance_deactivate_layer("Instances_1");
	
	instance_activate_object(PauseMenu);
		
	current_cursor = Rato_spr;
	window_mouse_set_locked(false);
}
else {
	instance_activate_layer("Instances");
	
	if (instance_exists(PauseMenu)) instance_deactivate_object(PauseMenu);
	
	window_mouse_set_locked(true);
}

draw_sprite(current_cursor, -103, current_mouse_pos.x, current_mouse_pos.y);

if (elapsed_time >= 3.0) {
	unlerped_inv_y_offset = 128;
	elapsed_time = 0;
}

if (keyboard_check_pressed(ord("I"))) {
	show_inventory = !show_inventory;
	audio_sound_pitch(OpenInv, random_range(0.75, 1.25));
    audio_play_sound(OpenInv, 10, false);
}

if (keyboard_check_pressed(vk_escape)) {
	show_pause_menu = !show_pause_menu;
}

if (mouse_check_button_pressed(mb_left)) {
	mouse_clicked = true;
}

elapsed_time += delta_time / 1000000;