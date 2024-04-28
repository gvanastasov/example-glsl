#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    float columns = 8.0;
    float rows = 8.0;

    st = vec2(st.x * columns, st.y * rows);

    vec2 cell = floor(st);
    
    /*
        0.0 if cell is even and 1.0 if cell is odd
    */
    float isOdd = mod(cell.x + cell.y, 2.0);

    color = mix(vec3(1.0), vec3(0.0), isOdd);

	gl_FragColor = vec4(color, 1.0);
}
