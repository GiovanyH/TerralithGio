if event_data[? "event_type"] == "sprite event"
{
    switch (event_data[? "message"])
    {
		case "AxeAttack":
			if (tilemap_get(arvores_tilemap, (obj_Player.x / 16) + obj_Player.image_xscale, (obj_Player.y / 16)) != 0) {
				part_particles_burst(ps, obj_Player.x + obj_Player.image_xscale, (obj_Player.y / 16), DestroiArvore);
				
				var madeira = instance_create_layer(obj_Player.x + obj_Player.image_xscale, obj_Player.y-32, 3, DropItem);
				madeira.IMPULSO_X = random_range(-3, 3);
				madeira.current_sprite = MadeiraBasica_spr;
				madeira.item_name = "Wood";
					
				audio_sound_pitch(WoodPunch, random_range(0.75, 1.25));
				audio_play_sound(WoodPunch, 10, false);
					
				//_params.g_ShakeSpeed = 0.001;
				//fx_set_parameters(_fx_struct, _params);
			}
		break;
    }
}