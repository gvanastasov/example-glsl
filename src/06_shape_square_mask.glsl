#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float squareMask(in vec2 st, in float size) {
    vec2 bl = step(vec2(size),st);
    vec2 tr = step(vec2(size),1.0-st);
    return bl.x * bl.y * tr.x * tr.y;
}

float squareMaskSmooth(in vec2 st, in float size) {
    vec2 bl = smoothstep(vec2(0.0), vec2(size), st);
    vec2 tr = smoothstep(vec2(0.0), vec2(size), 1.0-st);
    return bl.x * bl.y * tr.x * tr.y;
}

float outline (in vec2 st, in float offset, in float size) {
    return squareMask(st, offset) - squareMask(st, offset + size);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float maskSmooth = squareMaskSmooth(st, 0.1);
    
    float mask = squareMask(st, 0.1);
    
    float outline = outline(st, 0.1, 0.01);

    vec3 color = mix(vec3(1.0, 0.0, 0.0), vec3(0.0), maskSmooth);
    color = mix(color, vec3(0.0, 1.0, 0.0), mask);
    color = mix(color, vec3(0.0, 0.0, 1.0), outline);

    gl_FragColor = vec4(color,1.0);
}