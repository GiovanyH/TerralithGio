// Get the camera's position and view dimensions
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

// Calculate the starting and ending tile indices based on the camera view
var start_tile_x = floor(_cam_x / 16) - 5;
var end_tile_x = floor((_cam_x + _view_width) / 16) + 5;
var start_tile_y = floor(_cam_y / 16) - 20;
var end_tile_y = floor((_cam_y + _view_height) / 16) + 5;

elapsed_time += delta_time / 100000;

for (var i = start_tile_x; i <= end_tile_x; i++) {
    for (var j = start_tile_y; j <= end_tile_y; j++) {
		if (i > 1 && i < world_sizex - 2 && j > 0 && j < world_sizey) {
			var current_water = World.water_map[i];
			var current_water2 = tilemap_get(World.water_tilemap, i, j);
			
			if (current_water != 0 && j > current_water && j < current_water + 2 && current_water2 != 0) {
				shader_set(waves_shader);
		        var tile_x = i * 16;  // Calculate the x position of the tile
		        var tile_y = j * 16;  // Calculate the y position of the tile
				
				var u_pos = shader_get_uniform(waves_shader, "time");
				
				shader_set_uniform_f(u_pos, elapsed_time * 0.1);
				
		        draw_rectangle(tile_x, tile_y, tile_x + 15, tile_y + 3, false); // Draw the rectangle
				shader_reset();
			}
			
			// this is really commented
			if (current_water != 0 && j > current_water && j < current_water + 2 && current_water2 != 0) {
				shader_set(reflection_shader);
		        var tile_x = i * 16;
		        var tile_y = j * 16;
				
				var r_pos = shader_get_uniform(reflection_shader, "reflectionPos");
				var r_size = shader_get_uniform(reflection_shader, "reflectionSize");
				
				shader_set_uniform_f(r_pos, tile_x, tile_y);
				shader_set_uniform_f(r_size, 16, 16);
				
		        draw_rectangle(tile_x, tile_y, tile_x + 15, tile_y + 15, false); // Draw the rectangle
				shader_reset();
			}
			
			if (current_water != 0 && j > current_water && current_water2 != 0) {
				shader_set(water_ref);
		        var tile_x = i * 16;  // Calculate the x position of the tile
		        var tile_y = j * 16;  // Calculate the y position of the tile
				
				var u_pos = shader_get_uniform(water_ref, "start_position");
				var m_pos = shader_get_uniform(water_ref, "max_height");
				
				shader_set_uniform_f(u_pos, j);
				shader_set_uniform_f(m_pos, current_water);
				
		        draw_rectangle(tile_x, tile_y, tile_x + 15, tile_y + 15, false); // Draw the rectangle
				shader_reset();
				
			}
		}
    }
}