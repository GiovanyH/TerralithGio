view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

if (keyboard_check(ord("M"))) {
	zoom_level = 20.0;
}
else {
	zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.25, 2);
}

new_w = lerp(view_w, zoom_level * default_zoom_width, 0.2);
new_h = lerp(view_h, zoom_level * default_zoom_height, 0.2);

camera_set_view_size(view_camera[0], new_w, new_h);