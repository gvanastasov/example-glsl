#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159

#define FREQUENCE 2.0
#define ARC_ANGLE 130.0
#define ARM_LEN 0.5

uniform vec2 u_resolution;
uniform float u_time;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius-feather, radius, dot(dist,dist) * 4.0);
}

mat2 pendelumMatrix() {
    float angle = sin(u_time * FREQUENCE) * PI * ARC_ANGLE / 360.;
    return mat2(sin(angle), 0, 0, cos(angle)) * 0.5 * ARM_LEN;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    st += pendelumMatrix() * vec2(1.0, 1.0);

    /*
        Notice we dont move the center of the circle, we move the origin of the space
        its relative to it.
    */
    float mask = maskCircle(st, vec2(0.5, 0.5), 0.005, 0.001);

    vec3 color = vec3(st, 0);
    color = mix(color, vec3(0.0, 0.0, 1.0), mask);

    gl_FragColor = vec4(color, 1.0);
}
