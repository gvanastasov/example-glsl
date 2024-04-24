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
    
    vec2 plot = vec2((sin((st.x - 0.5 + u_time) * PI) + 1.0) * 0.5, st.y);
    vec2 plot2 = vec2((cos((st.x - 0.5 + u_time) * PI) + 1.0) * 0.5, st.y);

    vec3 grad = vec3(plot.x);
    float c = curve(plot);
    float c2 = curve(plot2);

    vec3 color = (1.0 - c - c2) * grad + c * vec3(1.0,0.0,0.0) + c2 * vec3(0.0,0.0,1.0);

	gl_FragColor = vec4(color,1.0);
}