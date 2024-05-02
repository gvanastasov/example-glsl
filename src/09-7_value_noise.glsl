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
	
	vec2 u = f * f * (3.0 - 2.0 * f);

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