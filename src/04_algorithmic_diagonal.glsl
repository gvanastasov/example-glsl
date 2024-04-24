#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

/*
    declaration order matters
*/
float diagonal(vec2 st){
    /*
        if 
            st.y === st.x, the result of 1.0,
        else
            the result of 0.0

        this gives us a diagonal line

        since if-statement is an expensive operation, we can use
        only mathematical operations to achieve the same result
    */
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 grad = vec3(st.x);
    float d = diagonal(st);

    /*
        mix function is a linear interpolation function
        mix(a, b, t) = (1 - t) * a + t * b

        this function is used to blend two colors
            first being the gradient color
            second being the diagonal color
    */
    vec3 color = (1.0 - d) * grad + d * vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}