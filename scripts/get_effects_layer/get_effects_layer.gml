// made by Giovany
function get_effects_layer() {
	if (layer_exists("Effects")) {
		return part_system_create_layer("Effects", false);
	}
	else {
		return part_system_create_layer("Instances", false);
	}
}