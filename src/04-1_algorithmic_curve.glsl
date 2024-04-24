#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float curve(vec2 st) {
    /*
        if 
            func(st.y) === func(st.x), the result of 1.0,
        else
            the result of 0.0

        this gives us a curve (or line)
    */
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    
    /*
        since we are dealing with normalized vector here, result of taking the power
        will yield values lower than the input (ex. 0.5 -> 0.03125, 0.1 -> 0.00001, etc.)

        as a result we get lower values for x and higher values for y, which forms a
        growing curve (sort of exponential) on the x-axis.
    */
    vec2 plot = vec2(pow(st.x, 5.0), st.y);

    vec3 grad = vec3(plot.x);
    float c = curve(plot);

    vec3 color = (1.0 - c) * grad + c * vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}