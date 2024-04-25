#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    float r = step(0.5, 0.5 * sin(2.0 * PI * st.x + 0.0) + 0.5);
    float g = step(0.5, 0.5 * sin(2.0 * PI * st.x + 2.0 * PI / 3.0) + 0.5);
    float b = step(0.5, 0.5 * sin(2.0 * PI * st.x + 4.0 * PI / 3.0) + 0.5);
    
    vec3 color = vec3(r, g, b);

    gl_FragColor = vec4(color,1.0);
}