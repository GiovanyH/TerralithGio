player_position = [0, 0];

function look_at(target_x, target_y) {
    var angle = point_direction(x, y, target_x, target_y);
    
    image_angle = lerp(image_angle, angle, 0.05);
}