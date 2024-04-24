#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

const float PI = 3.14159265359;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    
    /*
        we take sin of the x coordinate and add 1 to make it positive
        then we divide by 2 to make it between 0 and 1 (normalized)

        we also mutiple by PI to make the wave more frequent this should give
        us a normalization along the x axis (so we get all the values between 0 and 1)

        we then add the time to make the wave move
    */
    vec2 plot = vec2((sin((st.x - 0.5 + u_time) * PI) + 1.0) * 0.5, st.y);

    vec3 grad = vec3(plot.x);
    float c = curve(plot);

    vec3 color = (1.0 - c) * grad + c * vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}