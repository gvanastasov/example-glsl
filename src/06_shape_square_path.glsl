#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float squareMask(in vec2 st, in vec2 pos, in float size) {
    vec2 dist = abs(st - pos) - size;
    return step(max(dist.x, dist.y), 0.0);
}

float outline (in vec2 st, in vec2 pos, in float offset, in float size) {
    return squareMask(st, pos, offset) - squareMask(st, pos, offset - size);
}
vec2 squarePathSample(in float speed, in float distance) {
    float offset = 1.0 - distance;

    float t = mod(u_time * speed, 4.0);
    float s1 = step(1.0, t);
    float s2 = step(2.0, t);
    float s3 = step(3.0, t);

    float x1 = (distance - offset) * t + offset;
    float x2 = distance;
    float x3 = (distance - offset) * (3.0 - t) + offset;
    float x4 = offset;

    float y1 = distance;
    float y2 = (distance - offset) * (2.0 - t) + offset;
    float y3 = offset;
    float y4 = (distance - offset) * (t - 3.0) + offset;

    vec2 pos = vec2(
        mix(x1, mix(x2, mix(x3, x4, s3), s2), s1),
        mix(y1, mix(y2, mix(y3, y4, s3), s2), s1)
    );

    return pos;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float outline = outline(st, vec2(0.5, 0.5), 0.4, 0.02);

    float path = squareMask(st, squarePathSample(0.5, 0.9), 0.1);

    vec3 color = vec3(0.0);
    color = mix(color, vec3(0.0, 0.0, 1.0), outline);
    color = mix(color, vec3(1.0, 1.0, 0.0), path);

    gl_FragColor = vec4(color,1.0);
}