#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float random (vec2 st) {
    return
        /*
            just a random vector product
        */
        fract(
            sin(
                dot(st.xy, vec2(12.345, 67.890))
            ) * 43758.5453123);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st *= 16.0;

    vec2 ipos = floor(st);

    float rnd = random( ipos );

    vec3 color = vec3(rnd);

    gl_FragColor = vec4(color, 1.0);
}