#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }
vec3 taylorInvSqrt(vec3 r) { return 1.79284291400159 - 0.85373472095314 * r; }

// Based on Ian McEwan, Ashima Arts
float simplexNoise2D(vec2 st) {
    const float F2 = 0.366025403;

    const float G2 = 0.211324865;

    const float G = 0.0243902439;

    vec2 i = floor(st + dot(st, vec2(F2)));

    vec2 x0 = st - i + dot(i, vec2(G2));

    vec2 i1;
    i1 = mix(vec2(1.0, 0.0), vec2(0.0, 1.0), step(x0.x, x0.y));

    vec2 x1 = x0 - i1 + vec2(G2);
    vec2 x2 = x0 - 1.0 + 2.0 * vec2(G2);

    i = mod289(i);
    vec3 py = permute(i.y + vec3(0.0, i1.y, 1.0));
    vec3 px = permute(py + i.x + vec3(0.0, i1.x, 1.0 ));
    vec3 p0 = px;

    float n0 = dot(x0, x0);
    float n1 = dot(x1, x1);
    float n2 = dot(x2, x2);

    vec3 m = max(0.5 - vec3(n0, n1, n2), 0.0);

    m = m * m;
    m = m * m;

    vec3 x = 2.0 * fract(p0 * vec3(G)) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    m *= taylorInvSqrt(a0 * a0 + h * h);

    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * vec2(x1.x, x2.x) + h.yz * vec2(x1.y, x2.y);

    return 130.0 * dot(m, g);
}

float turbolence (in vec2 st) {
    const int octaves = 6;
    float value = 0.0;
    float amplitude = 0.5;
    float gain = 0.6;
    float sd = 1.3;

    for (int i = 0; i < octaves; i++) {
        value += amplitude * abs(simplexNoise2D(st));
        st *= sd;
        amplitude *= gain;
    }

    return value;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 color = vec3(0.0);
    color += turbolence(st * 10.0);

    gl_FragColor = vec4(color, 1.0);
}