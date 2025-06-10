varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float opacity; // Controls transparency

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = vec4(texColor.rgb, texColor.a * opacity) * v_vColour;
}
