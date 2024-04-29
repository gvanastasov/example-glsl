#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    float columns = 3.0;
    float rows = 3.0;

    // subdivide
    st = vec2(st.x * columns, st.y * rows);

    // offset
    vec2 cell = floor(st);
    float isOddRow = mod(cell.y, 2.0);
    float offsetX = 0.5;

    st.x += isOddRow * offsetX;

    // normalize
    st = fract(st);

    color = vec3(st, 0.0);
	gl_FragColor = vec4(color, 1.0);
}
