#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    // Denmark
    vec3 dk = vec3(0.7, 0.1, 0.1);
    float vertical = step(0.40, st.x) - step(0.60, st.x);
    float horizontal = step(0.40, st.y) - step(0.60, st.y);
    float cross = max(vertical, horizontal);
    dk = mix(dk, vec3(1.0, 1.0, 1.0), cross);

    // Bulgaria
    vec3 bg = vec3(0.7, 0.1, 0.1);
    bg = mix(bg, vec3(0.0, 0.8, 0.0), step(0.33, st.y));
    bg = mix(bg, vec3(1.0, 1.0, 1.0), step(0.66, st.y));

    gl_FragColor = vec4(mix(bg, dk, sin(u_time * 0.5)),1.0);
}