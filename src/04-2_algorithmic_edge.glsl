#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    
    /*
        if st.x > 0.5 
            plot.x = 1.0
        else 
            plot.x = 0.0
    */
    vec2 plot = vec2(step(0.5, st.x), st.y);

    vec3 grad = vec3(plot.x);
    float c = curve(plot);

    vec3 color = (1.0 - c) * grad + c * vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}