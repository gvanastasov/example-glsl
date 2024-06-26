#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

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
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec2 translate = vec2(cos(u_time),sin(u_time));
    st += translate * 0.35;

    float mask = maskCross(st, vec2(0.5, 0.5), 0.015, 0.05);

    vec3 color = vec3(st, 0);
    color = mix(color, vec3(0.0, 0.0, 1.0), mask);

    gl_FragColor = vec4(color, 1.0);
}
