GRAVITY_CONSTANT = 1.0;
IMPULSO_X = 0.0;

move_x = 0;
move_y = 0;

current_sprite = MadeiraBasica_spr;
item_name = "Wood";

spriteoffsetx = 0;
spriteoffsety = 0;

collect_cooldown = 0.0;

smooth_time = 0;

floor_tilemap = layer_tilemap_get_id("Tiles_1");

function collect() {
	if (obj_Player.collect_item(item_name) == 0) instance_destroy();
}