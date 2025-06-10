move_x = 0.0;
move_y = 0.0;

dir_x = 0.0;
dir_y = 0.0;

inc = 0.02;

self_gravity = 0.0;

move_speed = 6.0;

air_perlin_noisex = random(3000);
air_perlin_noisey = random(3000);

tilemap = layer_tilemap_get_id("Tiles_1");
water_tilemap = layer_tilemap_get_id("Tiles_5");

function look_at(target_x, target_y) {
    // Calculate the direction angle to the target
    var angle = point_direction(0, 0, target_x, target_y);
    
    // Set the player's rotation to face the target
    image_angle = angle;
}