var videoData = video_draw();
var videoStatus = videoData[0];

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

if (videoStatus == 0) {
	draw_surface(videoData[1], _cam_x, _cam_y);
}