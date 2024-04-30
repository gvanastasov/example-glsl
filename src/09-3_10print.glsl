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

vec2 pattern(in vec2 _st, in float _index){
    _index = fract(((_index- 0.5 ) * 2.0));

    // specify the start and end of a vector based on random
    // noise value, aka mixing RND and FIXED values into the 
    // plot function
    _st = mix(_st, vec2(1.0) - _st, step(_index, 0.75));
    _st = mix(_st, vec2(1.0 - _st.x, _st.y), step(_index, 0.5));
    _st = mix(_st, 1.0 - vec2(1.0 - _st.x, _st.y), step(_index, 0.25));

    return _st;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    st *= 10.0;
    st.x += u_time * 2.0;
    
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    vec2 tile = pattern(fpos, random( ipos ));

    float mask =
        smoothstep(tile.x - 0.3, tile.x, tile.y) -
        smoothstep(tile.x, tile.x + 0.3, tile.y);
    
    mask = 
        (step(length(tile), 0.6) - step(length(tile), 0.4) ) +
        (step(length(tile - vec2(1.0)), 0.6) - step(length(tile - vec2(1.0)), 0.4) );

    vec3 color = vec3(mask);

    gl_FragColor = vec4(color, 1.0);
}