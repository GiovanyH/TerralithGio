/// @function raycast_tiles(x1, y1, x2, y2, tilemap)
/// @param {real} x1 - Start X coordinate
/// @param {real} y1 - Start Y coordinate
/// @param {real} x2 - End X coordinate
/// @param {real} y2 - End Y coordinate
/// @param {tilemap} tilemap - The tilemap to check against
/// @returns {struct} - A structure containing x and y of the collision position, or noone if no collision.
function raycast_tiles(x1, y1, x2, y2, tilemap) {
    var dir_x = x2 - x1;
    var dir_y = y2 - y1;
    var length = point_distance(x1, y1, x2, y2);
    
    // Normalize direction
    var step_x = dir_x / length;
    var step_y = dir_y / length;

    // Raycasting loop
    for (var i = 0; i < length; i += 1) {
        var check_x = x1 + step_x * i;
        var check_y = y1 + step_y * i;

        // Convert pixel coordinates to tile coordinates
        var tile_x = floor(check_x / 16);
        var tile_y = floor(check_y / 16);

        // Check for a tile at the calculated position
        var tile_index = tilemap_get(tilemap, tile_x, tile_y);
        if (tile_index != 0) { // -1 means no tile present
            return [check_x, check_y]; // Return the collision position
        }
    }
    
    return noone; // No collision
}
