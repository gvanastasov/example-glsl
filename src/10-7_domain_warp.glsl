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
    float gain = 0.5;
    float sd = 2.0;

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

    st *= 4.0;

    // create first cloud
    vec2 q = vec2(0.0);
    q.x = cloud( st + 0.0 * u_time);
    q.y = cloud( st + vec2(1.0));

    // create distortion via the first cloud
    vec2 r = vec2(0.0);
    r.x = cloud(st + 1.0 * q + vec2(1.7,9.2)+ 0.2 * u_time);
    r.y = cloud(st + 1.0 * q + vec2(8.3,2.8)+ 0.1 * u_time);

    // create final value from distorted (warped) space 
    float f = cloud(st + r);

    vec3 color = vec3(0.0);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    gl_FragColor = vec4(color, 1.0);
}