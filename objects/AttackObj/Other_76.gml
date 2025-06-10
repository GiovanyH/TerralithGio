/// @description Insert description here
// You can write your code in this editor

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
        case "StopAttack":
			obj_Player.is_attacking = false;
            //instance_destroy(self);
        break;
    }
}