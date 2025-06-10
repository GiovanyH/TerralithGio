//
// Fragment shader com reflexão em uma região específica
//

varying vec3 v_vPosition;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 reflectionPos;       // A posição da reflexão (x, y) na tela
uniform vec2 reflectionSize;      // O tamanho da área da reflexão (width, height)

void main()
{
    gl_FragColor = vec4(1.0, 0.0, 0.0, 0.0); // Cor sólida, por exemplo
}
