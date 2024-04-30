#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float random (vec2 st) {
    return
        /*
            updating the vector changes the maze
        */
        fract(
            sin(
                dot(st.xy, vec2(12.345, 67.890))
            ) * 43758.5453123);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st *= vec2(16, 4);
    st.x += u_time * 2.0 * (mix(-1.0, 1.0, mod(floor(st.y), 2.0)));
    
    vec2 ipos = floor(st);

    vec2 fpos = fract(st);

    float rnd = random( ipos );

    float mask = step(fpos.x, rnd) - step(fpos.x, rnd - 0.8);
    
    vec3 color = vec3(mask);

    gl_FragColor = vec4(color, 1.0);
}