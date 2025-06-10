function get_biome(current_temperature, current_humidity) {
	if (current_humidity > 95) return 3;
	return map_value(current_temperature, 0, 80, -0.5, 2.5);
}