#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec2 plot = vec2((sin((st.x - 0.5) * PI) + 1.0) * 0.5, st.y);

    vec3 grad = vec3(plot.x);
    float c = curve(plot);

    vec3 color = mix(grad, vec3(1.0, 0.0, 0.0), 1.0 - step(plot.x, st.y));

    gl_FragColor = vec4(color,1.0);
}