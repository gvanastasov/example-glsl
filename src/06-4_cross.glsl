#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

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
    
    float mask = maskCross(st, vec2(0.5, 0.5), 0.015, 0.05);

    vec3 color = vec3(mask);

    gl_FragColor = vec4(color, 1.0);
}
