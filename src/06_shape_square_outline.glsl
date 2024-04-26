#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float squareMask(in vec2 st, in vec2 pos, in float size) {
    vec2 dist = abs(st - pos) - size;
    return step(max(dist.x, dist.y), 0.0);
}

float outline (in vec2 st, in vec2 pos, in float offset, in float size) {
    return squareMask(st, pos, offset) - squareMask(st, pos, offset - size);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float outline = outline(st, vec2(0.3, 0.3), 0.1, 0.01)
        + outline(st, vec2(0.6, 0.6), 0.3, 0.03);

    vec3 color = mix(vec3(0.0), vec3(1.0, 0.0, 0.0), outline);

    gl_FragColor = vec4(color,1.0);
}