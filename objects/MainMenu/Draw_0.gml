var menu_width = (biggest * padding_size) + padding_size;
var menu_height = (array_length(menu_options) * (padding_size * 2)) + (padding_size * 2);

var menu_pos_x = x - (menu_width * 0.5);
var menu_pos_y = y - (menu_height * 0.5);

draw_rectangle_color(menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height, c_black, c_black, c_black, c_black, false);

for (var i = 0; i < array_length(menu_options); i++) {
	var string_to_draw = menu_options[i];
	if (selected == i) string_to_draw = menu_options[i] + "*";
	draw_text(menu_pos_x + padding_size + ((biggest - string_length(string_to_draw)) * (padding_size * 0.5)), menu_pos_y + (i * padding_size * 2) + padding_size, string_to_draw);
}

draw_rectangle_color(menu_pos_x, menu_pos_y, menu_pos_x + menu_width, menu_pos_y + menu_height, c_white, c_white, c_white, c_white, true);