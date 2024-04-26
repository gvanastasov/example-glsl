#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

/*
    Calculate a square mask with a given size
    of inset from the edges of parent 2D system.
*/
float squareMask(in vec2 st, in float size) {
    vec2 bl = step(vec2(size), st);
    vec2 tr = step(vec2(size),1.0 - st);
    return bl.x * bl.y * tr.x * tr.y;
}

/*
    Calculate a square mask with given position
    and size within parent 2D system.
*/
float squareMask(in vec2 st, in vec2 center, in float size) {
    vec2 dist = abs(st - center) - size * 0.5;
    return step(max(dist.x, dist.y), 0.0);
}

/*
    Calculate a smooth square mask with a given size
    of inset from the edges of parent 2D system.
*/
float squareMaskSmooth(in vec2 st, in float size) {
    vec2 bl = smoothstep(vec2(0.0), vec2(size), st);
    vec2 tr = smoothstep(vec2(0.0), vec2(size), 1.0-st);
    return bl.x * bl.y * tr.x * tr.y;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float inset = squareMask(st, 0.1);
    float insetSmooth = squareMaskSmooth(st, 0.1);
    float rectMask = squareMask(st, vec2(0.3, 0.3), 0.3);

    vec3 color = mix(vec3(1.0, 0.0, 0.0), vec3(0.0), insetSmooth);
    color = mix(color, vec3(0.0, 0.0, 1.0), inset);
    color = mix(color, vec3(0.0, 1.0, 0.0), rectMask);

    gl_FragColor = vec4(color,1.0);
}