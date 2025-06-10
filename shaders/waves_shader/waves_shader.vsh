attribute vec3 in_Position;              // Vertex position
attribute vec2 in_TextureCoord;          // Texture coordinates
attribute vec4 in_Colour;                // Vertex color

varying vec2 v_vTexcoord;                // Pass texture coordinates to the fragment shader
varying vec4 v_vColour;                   // Pass color to the fragment shader
varying vec3 v_vPosition;                 // Pass vertex position to the fragment shader

uniform float time;

void main()
{
    // Hard-coded wave parameters
    float amplitude = 1.25;               // Amplitude of the waves
    float frequency = 0.25;                // Frequency of the waves
    float speed = 4.0;                    // Speed of wave propagation

    // Calculate the wave effect based on the x position of the vertex
    float wave = sin(in_Position.x * frequency + time * speed) * amplitude;

    // Offset the y position of the vertex based on the wave
    vec3 displacedPosition = in_Position;
    displacedPosition.y += wave; // Modify the y position based on the wave

    // Set the final position of the vertex
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(displacedPosition, 1.0);

    // Pass through other attributes
    v_vTexcoord = in_TextureCoord;
    v_vColour = vec4(1.0, 1.0, 1.0, 0.9);
    v_vPosition = displacedPosition;
}
