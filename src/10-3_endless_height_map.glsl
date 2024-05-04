#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float random (vec2 st) {
    return
        fract(
            sin(
                dot(st.xy, vec2(12.345, 70.890))
            ) * 43758.5453123);
}

float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float cloud (in vec2 st) {
    const int octaves = 6;
    float value = 0.0;
    float amplitude = 0.5;
    float gain = 0.6;
    float sd = 1.3;

    for (int i = 0; i < octaves; i++) {
        value += amplitude * noise(st);
        st *= sd;
        amplitude *= gain;
    }

    return value;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    st += u_time * 0.1;

    vec3 color = vec3(0.0, 0.18, 1.0);

    float h = cloud(st * 10.0);

    color = mix(color, vec3(0.0, 0.6353, 1.0), step(0.3, h));
    color = mix(color, vec3(1.0, 0.9451, 0.702), step(0.4, h));
    color = mix(color, vec3(1.0, 0.8667, 0.2784), step(0.5, h));
    color = mix(color, vec3(0.0, 1.0, 0.1647), step(0.55, h));
    color = mix(color, vec3(0.0745, 0.4745, 0.1412), step(0.6, h));
    color = mix(color, vec3(0.4471, 0.2549, 0.0745), step(0.7, h));
    color = mix(color, vec3(1.0, 1.0, 1.0), step(0.8, h));

    gl_FragColor = vec4(color,1.0);
}