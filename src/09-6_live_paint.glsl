#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float random(in float x) 
{
    return fract(sin(x) * 1e4);
}

float random (vec2 st) {
    return
        fract(
            sin(
                dot(st.xy, vec2(12.345, 67.890))
            ) * 43758.5453123);
}

float squareMaskSmooth(in vec2 st, in float size) {
    vec2 bl = smoothstep(vec2(0.0), vec2(size), st);
    vec2 tr = smoothstep(vec2(0.0), vec2(size), 1.0-st);
    return bl.x * bl.y * tr.x * tr.y;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    st.x *= 3.0;

    vec2 sti = floor(st);
    float index = mod(sti.x, 3.0);

    vec2 nS = vec2(st * 25.0);
    nS.y += u_time * (1. + index) * mix(1.0, -1.0, mod(sti.x, 2.0));

    vec2 i = floor(nS);
    vec2 f = fract(nS);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f*f*(3.0-2.0*f);

    float rand = mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;

    float mask = smoothstep(squareMaskSmooth(fract(st), 0.5 * rand) * rand, .2, rand);

    // base color
    vec3 color = vec3(0.2784, 0.0627, 0.0627);
    color = mix(color, vec3(0.2784, 0.0627, 0.0627), step(1.0, index));
    color = mix(color, vec3(0.3882, 0.1255, 0.0078), step(2.0, index));
    
    // top coat
    vec3 tcolor = mix(color, vec3(0.9216, 0.0471, 0.0471), step(0.0, index));
    tcolor = mix(tcolor, vec3(0.6784, 0.0431, 0.0431), step(1.0, index));
    tcolor = mix(tcolor, vec3(0.9922, 0.8392, 0.5098), step(2.0, index));

    color = mix(color, tcolor, 1. - mask);

    // color = vec3(rand);

    gl_FragColor = vec4(color, 1.0);
}