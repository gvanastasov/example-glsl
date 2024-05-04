#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

float noise(in float x) {
    return fract(sin(x) * 1e4) * 2.0 - 1.0;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;

    st *= 16.0;
    st.y -= 8.0;
    st.x -= u_time;

    const int octaves = 4;
    float lacunarity = 1.0;
    float gain = 0.5;
    float amplitude = 1.;
    float frequency = 1.;

    float y = st.y;
    float x = sin(st.x * frequency) * amplitude;

    // adding waves with phase difference will create destructive interference
    // which cancels the wave amplitude out 
    float x1 = x + sin(st.x * frequency + PI) * 1.0;

    // adding waves with same frequency will amplify the wave
    float x2 = sin(st.x * frequency) * 1.5;
    x2 += sin(st.x * frequency) * 0.5;

    // adding waves with different frequency and amplitude 
    // will create a more complex wave
    float t = 0.01 * (-u_time * 130.0);
    float x3 = x + sin(st.x * 2.0 + t) * 0.5;
    x3 += sin(st.x * 1.8 + t * 1.2) * 0.5;
    x3 += sin(st.x * 0.2 + t * 0.4) * 0.5;

    // using noise to compute the wave
    float x4 = x;
    for (int i = 0; i < octaves; i++) {
        x4 += amplitude * sin(noise(frequency) * st.x + t);
        frequency *= lacunarity;
        amplitude *= gain;
    }

    vec3 color = vec3(curve(vec2(x, y)));

    color += vec3(1.0, 0.0, 0.0) * curve(vec2(x1, y));

    color += vec3(1.0, 1.0, 0.0) * curve(vec2(x2, y));

    color += vec3(0.0, 1.0, 0.0) * curve(vec2(x3, y));

    color += vec3(0.0, 1.0, 1.0) * curve(vec2(x4, y));

	gl_FragColor = vec4(color,1.0);
}