#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;

vec2 tile(vec2 st, float n) {
    st *= 4.0;
    st = fract(st);
    return st;
}

vec2 skew(vec2 p, float n) {
    // Skew
    vec2 uv = vec2(
        p.x - p.y * n,
        p.y * sqrt(3.0) * 0.5
    );

    // Tile
    uv = fract(uv);

    // Unskew
    vec2 st = vec2(
        uv.x + uv.y / sqrt(3.0),
        uv.y * 2.0 / sqrt(3.0)
    );

    return st;
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    
    st = tile(st, 4.0);
    st = skew(st, 0.2);
    
    vec3 color = vec3(st, 0.0);
	gl_FragColor = vec4(color, 1.0);
}
