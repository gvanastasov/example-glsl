#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

float random (vec2 st) {
    return
        fract(
            sin(
                dot(st.xy, vec2(12.345, 67.890))
            ) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
	
    // get smooth value inside each individual fraction of our grid space
    // aka. normalize the value to be between 0 and 1 for each fraction
	vec2 u = f * f * (3.0 - 2.0 * f);

    // get a random VALUE for each corner
    // and interpolate between them using the smooth value to get a fixed
    // VALUE without any interpolation artifacts from neighboring cells
    // hence called VALUE noise
    return mix(
        mix(
            random(i + vec2(0.0, 0.0)), random(i + vec2(1.0, 0.0)), u.x
        ),
        mix(
            random(i + vec2(0.0, 1.0)), random(i + vec2(1.0, 1.0)), u.x
        ),
        u.y
    );
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    vec2 pos = vec2(st * 100.0);

    vec3 color = vec3(noise(pos));

    gl_FragColor = vec4(color, 1.0);
}