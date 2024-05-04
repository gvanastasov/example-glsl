#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;

    st *= 16.0;
    st.y -= 8.0;
    st.x -= u_time;

    float amplitude = 1.;
    float frequency = 1.;

    float y = st.y;
    float x = sin(st.x * frequency) * amplitude;

    // adding waves with phase difference will create destructive interference
    // which cancels the wave amplitude out 
    x += sin(st.x * frequency + PI) * 1.0;


    // adding waves with same frequency will amplify the wave
    x += sin(st.x * frequency) * 0.5;
    x += sin(st.x * frequency) * 0.5;

    // adding waves with different frequency and amplitude 
    // will create a more complex wave
    float t = 0.01 * (-u_time * 130.0);
    x += sin(st.x * 2.0 + t) * 0.5;
    x += sin(st.x * 1.8 + t * 1.2) * 0.5;
    x += sin(st.x * 0.2 + t * 0.4) * 0.5;

    vec2 plot = vec2(x, y);

    float c = curve(plot);

    vec3 color = vec3(c);

	gl_FragColor = vec4(color,1.0);
}