var _fx_struct = layer_get_fx("ScreenShake");
var _params = fx_get_parameters(_fx_struct);

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
		case "AxeAttack":
			if (distance_to_object(obj_Player) < 5.0) {
				if (life <= 0) {
					sprite_index = ArvoreBasicaToco_spr;
					
					_params.g_ShakeSpeed = 0.005;
					fx_set_parameters(_fx_struct, _params);
				}
				else {
					part_particles_burst(ps, x, y-64, DestroiArvore);
				
					var madeira = instance_create_layer(x, y-32, 3, DropItem);
					madeira.IMPULSO_X = random_range(-3, 3);
					madeira.current_sprite = MadeiraBasica_spr;
					
					audio_sound_pitch(WoodPunch, random_range(0.75, 1.25));
					audio_play_sound(WoodPunch, 10, false);
					
					_params.g_ShakeSpeed = 0.001;
					fx_set_parameters(_fx_struct, _params);
					
					life--;
				}
			}
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}