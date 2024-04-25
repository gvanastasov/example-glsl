#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;

vec3 colorA = vec3(0.15, 0.27, 0.38);
vec3 colorB = vec3(1.0, 0.65, 0.0);

float circle(vec2 st, vec2 center, float radius) {
    vec2 dist = st - center;
    return length(dist) - radius;
}

void main() {
    vec2 st = (gl_FragCoord.xy) / u_resolution;
    
    float circle = circle(st, u_mouse / u_resolution, 0.01);

    vec3 color = mix(colorA, colorB, step(0.01, circle));

    gl_FragColor = vec4(color,1.0);
}
