// Create Event

ps = part_system_create_layer("Effects", false);

audio_play_sound_at(arvore_bird, x, y, 0, global.falloff_ref, global.falloff_max, 1, true, 0);
audio_play_sound_at(arvore_vento, x, y, 0, global.falloff_ref, global.falloff_max, 1, true, 0);

life = 4; // quantas batidas pra ela ir dbase