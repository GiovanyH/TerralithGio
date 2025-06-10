vx = camera_get_view_x(view_camera[0]);
vy = camera_get_view_y(view_camera[0]);

//Local variables setup
var _u_pos = u_pos;
var _u_zz = u_zz;
var _u_str = u_str;
var _u_dir = u_dir;
var _u_fov = u_fov;
var _u_pos2 = u_pos2;
var _vb = vb;
var _vx = vx;
var _vy = vy;
var _u_nmap = u_nmap;

//Shadow surface setup
if (!surface_exists(shad_surf)){
	shad_surf = surface_create(1366,768);
}

if (camera_get_view_width(view_camera[0]) != _view_width || camera_get_view_height(view_camera[0]) != _view_height) {
	surface_resize(application_surface,_view_width,_view_height);
	surface_resize(global.n_surf,_view_width,_view_height);
	
	if (!surface_exists(shad_surf)){
		shad_surf = surface_create(_view_width,_view_height);
	}
	else {
		surface_resize(shad_surf, _view_width, _view_height);
	}
}

_view_width = camera_get_view_width(view_camera[0]);
_view_height = camera_get_view_height(view_camera[0]);

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var start_tile_x = floor(_cam_x / 16) - 5;
var end_tile_x = floor((_cam_x + _view_width) / 16) + 5;
var start_tile_y = floor(_cam_y / 16) - 20;
var end_tile_y = floor((_cam_y + _view_height) / 16) + 5;

vertex_begin(vb,vf);
var _vb = vb;
for (var i = start_tile_x; i < end_tile_x; i++) {
	for (var j = start_tile_y; j < end_tile_y; j++) {
		if (i > 1 && i < World.world_sizex - 2 && j > 0 && j < World.world_sizey - 2) {
			var r_i = (i - start_tile_x);
			var r_j = (j - start_tile_y);
			
			var current_light = World.light_map[max(0, r_i + floor(_cam_x / 16))][max(0, r_j + floor(_cam_y / 16))];
			if (current_light != 0) {
				r_i = (max(0, r_i + floor(_cam_x / 16)) * 16);
				r_j = (max(0, r_j + floor(_cam_y / 16)) * 16);
				
				Quad(_vb,r_i-1,r_j,r_i+17,r_j);
				Quad(_vb,r_i+16,r_j-1,r_i+16,r_j+16);
		
				Quad(_vb,r_i+16,r_j+16,r_i,r_j+16);
				Quad(_vb,r_i,r_j+16,r_i,r_j-1);
			}
		}
	}
}
vertex_end(vb);

display_set_gui_maximize();

matrix_set(matrix_world,matrix_build(-vx,-vy,0,0,0,0,1,1,1));
surface_set_target(global.n_surf);
shader_set(shd_norm);
shader_reset();
surface_reset_target();

//Draw lights and shadows
surface_set_target(shad_surf);
draw_clear_alpha(c_black,0);
draw_surface_ext(application_surface,_vx,_vy, 1, 1,0,c_white,0.2);
with(obj_light){
	//Draw the shadows (AKA light blockers)
	gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_one);
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,x,y);
	vertex_submit(_vb,pr_trianglelist,-1);
	
	//Draw the Light
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha,bm_one,bm_zero,bm_zero);
	shader_set(shd_light);
	shader_set_uniform_f(_u_pos,x,y);
	shader_set_uniform_f(_u_zz,size);
	shader_set_uniform_f(_u_str,str);
	shader_set_uniform_f(_u_fov,fov);
	shader_set_uniform_f(_u_dir,dir);
	texture_set_stage(_u_nmap,surface_get_texture(global.n_surf));
	//draw_rectangle_color(_vx,_vy,_vx+320,_vy+180,color,color,color,color,0); //canvas for drawing the light
	draw_surface_ext(application_surface,_vx,_vy, 1, 1, 0,color,1);
}
shader_reset();
surface_reset_target();
matrix_set(matrix_world,matrix_build(0,0,0,0,0,0,1,1,1));


//Draw and blend the shadow surface to the application surface
gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
draw_surface(shad_surf,vx,vy);


//reset shader and blendmode 
gpu_set_blendmode(bm_normal);
