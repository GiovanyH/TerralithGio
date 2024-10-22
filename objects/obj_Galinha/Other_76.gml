/// @description Insert description here
// You can write your code in this editor

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
		case "SwordAttack":
			if (distance_to_object(obj_Player) < 5.0) {
				move_x += obj_Player.image_xscale * 512;
				jump();
			}
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}