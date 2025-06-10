// Fragment Shader
varying vec3 v_vPosition;

// left Y position
uniform float prev_position;
// middle Y position
uniform float start_position;
// right Y position
uniform float next_position;

uniform float x_position;

// of 16x16 blocks, already multiplied by 16

void main()
{
	float relative_px = abs((v_vPosition.x - x_position) / 16.0);
	float position_y;
	
	float middle_prev_pos = (prev_position + start_position) * 0.5;
	float middle_next_pos = (start_position + next_position) * 0.5;
	
	if (relative_px <= 0.5) {
		position_y = mix(middle_prev_pos, start_position, relative_px * 2.0);
	}
	if (relative_px >= 0.5) {
		position_y = mix(start_position, middle_next_pos, (relative_px - 0.5) * 2.0);
	}
	
    float relative_y = ((v_vPosition.y - position_y) / 16.0) / 6.0;

    float gradient = clamp(relative_y, 0.0, 1.0);

    gl_FragColor = vec4(0.0, 0.0, 0.0, gradient); // Black color with varying alpha
}
