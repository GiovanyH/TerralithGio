// Fragment Shader
varying vec3 v_vPosition;

uniform float start_position; // Starting y position for the gradient
uniform float max_height;

void main()
{
    float position_y = max_height;
    float relative_y = ((v_vPosition.y - (position_y * 16.0)) / 128.0); // Adjust for pixel scaling

    // Calculate the gradient based on the relative y position and the maximum height
    float gradient = clamp(relative_y, 0.0, 0.70); // Normalize based on max_height

    // Set the color to black with varying alpha based on the gradient
    gl_FragColor = vec4(0.0, 0.0, 1.0, gradient); // Black color with varying alpha
}
