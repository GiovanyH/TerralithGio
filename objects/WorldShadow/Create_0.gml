world_sizex = 937;
world_sizey = 250;

elapsed_time = 0.0;

prev_top_pos = 0;
top_pos = 0;
next_top_pos = 0;

last_light = 0;

// Get the camera's position and view dimensions
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _view_width = camera_get_view_width(view_camera[0]) * 3;
var _view_height = camera_get_view_height(view_camera[0]) * 3;

// Calculate the starting and ending tile indices based on the camera view
var start_tile_x = floor(_cam_x / 16) - 5;
var end_tile_x = floor((_cam_x + _view_width) / 16) + 5;
var start_tile_y = floor(_cam_y / 16) - 20;
var end_tile_y = floor((_cam_y + _view_height) / 16) + 5;