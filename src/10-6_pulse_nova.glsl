#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359
#define tau 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

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

float ridge(float h, float offset) {
    h = abs(h);
    h = offset - h;
    h = h * h;
    return h;
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float turbolence (in vec2 st) {
    const int octaves = 6;
    
    float amplitude = 0.5;
    float frequence = 1.0;
    float gain = 0.9;
    float lacunarity = 2.0;
    float offset = 0.1;

    float sum = 0.0;
    float prev = 1.0;
    
    for (int i = 0; i < octaves; i++) {
        float n = ridge(simplexNoise2D(rotate2d(u_time * frequence * 0.01) * st), offset);
        sum += n*amplitude;
        sum += n*amplitude * prev;
        prev = n;
        amplitude *= gain;
        frequence *= lacunarity;
    }

    return sum;
}

float circleMask(vec2 p) 
{
	float r = length(p);
	r = log(sqrt(r));
	return abs(mod(r*4.,tau)-3.14) * 3. +.2;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    st = st*2.0 - 1.0;

    st = st*4.0;
    
    float ridge = turbolence(st);

    st /= exp(mod(u_time, PI));
	
    ridge *= pow(abs((0.01-circleMask(st))), 1.5);

    vec3 color = vec3(0.1, 0.22, 0.4)/ridge;
	color=pow(abs(color),vec3(.99));

    gl_FragColor = vec4(color, 1.0);
}