inv_y_offset = 0.0;
unlerped_inv_y_offset = 0.0;

window_mouse_set_locked(true);

_cam_x = camera_get_view_x(view_camera[0]);
_cam_y = camera_get_view_y(view_camera[0]);

view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

zoom_level = 1;

default_zoom_width = camera_get_view_width(view_camera[0]);
default_zoom_height = camera_get_view_height(view_camera[0]);

new_h = 640;
new_w = 360;

item_offset = new vector(0, 0);

function get_player_pos() {
	if (instance_exists(obj_Player)) {
		return new vector(obj_Player.x, obj_Player.y);
	}
	return new vector(0, 0);
}

instance_deactivate_object(PauseMenu);

elapsed_time = 0;
show_inventory = false;
show_pause_menu = false;

held_pos = new vector(0, 0);
held_item = ["None", noone, 1];

current_cursor = Rato_spr;

pause_instance = noone;

player_vel = new vector(0.0, 0.0);
player_pos = new vector(0.0, 0.0);
player_oldpos = new vector(0.0, 0.0);

current_mouse_pos = new vector(get_player_pos().x, get_player_pos().y);
mouse_clicked = false;

mouse_position = new vector((floor(current_mouse_pos.x / 16) * 16) - 8, (floor(current_mouse_pos.y / 16) * 16) - 8);

old_mouse_pos = new vector(mouse_x, mouse_y);

mouse_pos = new vector(window_mouse_get_delta_x(), window_mouse_get_delta_y());

inside_player = false;