varying vec2 v_vTexcoord;                // Passed texture coordinates
varying vec4 v_vColour;                   // Passed color to the fragment shader

void main()
{
    // Use the passed color and texture coordinates
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
