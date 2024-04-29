#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius-feather, radius, dot(dist,dist) * 4.0);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);

    float columns = 8.0;
    float rows = 8.0;

    // subdivide
    st = vec2(st.x * columns, st.y * rows);

    // offset
    vec2 cell = floor(st);
    vec2 isOdd = mod(cell, 2.0);
    float offsetX = 1.0;

    float phaseX = mod(ceil(u_time), 2.);
    float phaseY = mod(ceil(u_time + offsetX), 2.);

    st.x += (isOdd.y * offsetX - (1. - isOdd.y) * offsetX) * u_time * phaseX;
    st.y += (isOdd.x * offsetX - (1. - isOdd.x) * offsetX) * u_time * phaseY;

    // normalize
    st = fract(st);

    float m = maskCircle(st, vec2(0.5), 0.5, 0.1);

    color = vec3(m);
	gl_FragColor = vec4(color, 1.0);
}
