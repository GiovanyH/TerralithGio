var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

camera_set_view_pos(view_camera[0], x - (_view_width * 0.5), y - (_view_height * 0.5));

var mouse_distance = [x - mouse_x, y - mouse_y];

x += mouse_distance[0] * 0.001;
y += mouse_distance[1] * 0.001;

if (keyboard_check_pressed(vk_up)) {
	change_selected(selected - 1);
}
else if (keyboard_check_pressed(vk_down)) {
	change_selected(selected + 1);
}

else if (keyboard_check_pressed(vk_enter)) {
	start_room();
}