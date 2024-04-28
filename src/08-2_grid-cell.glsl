#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    float columns = 3.0;
    float rows = 3.0;

    st = vec2(st.x * columns, st.y * rows);

    vec2 cell = floor(st);
    
    /*
        normalize the cell position to make it visible
        as color
    */
    cell.x = cell.x / columns;
    cell.y = cell.y / rows;

    color = vec3(cell, 0.0);

	gl_FragColor = vec4(color, 1.0);
}
