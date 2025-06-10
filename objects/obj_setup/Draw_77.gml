//draw the background then the application surface 
//draw_clear_alpha(c_teal,1);

var scale_x = 1 / (_view_width / 1366);
var scale_y = 1 / (_view_height / 768);

gpu_set_blendmode_ext(bm_one, bm_zero);
draw_surface_ext(application_surface,0,0,scale_x,scale_y,0,c_white,1);
gpu_set_blendmode(bm_normal);