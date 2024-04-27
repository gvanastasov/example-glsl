#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

mat2 scale(vec2 _scale) {
    return mat2(_scale.x, 0.0,
                0.0, _scale.y);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float maskRect(in vec2 space, in vec2 center, in vec2 size) {
    vec2 dist = abs(space - center) - size * 0.5;
    return step(max(dist.x, dist.y), 0.0);
}

float maskCross(vec2 st, in vec2 center, in float thickness, in float size) {
    return
        maskRect(st, center, vec2(thickness, size)) + 
        maskRect(st, center, vec2(size, thickness));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st -= vec2(0.5);
    st = rotate2d(fract(u_time * 0.5) * PI * 2.0) * scale( vec2(sin(u_time)+ 1.0) ) * st;
    st += vec2(0.5);

    float mask = maskCross(st, vec2(0.5, 0.5), 0.1, 0.03);

    vec3 color = vec3(st, 0);
    color = mix(color, vec3(0.0, 0.0, 1.0), mask);

    gl_FragColor = vec4(color, 1.0);
}
