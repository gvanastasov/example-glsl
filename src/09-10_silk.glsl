#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec2 random (vec2 st) {
    st = vec2( 
        dot(st,vec2(127.1,311.7)),
        dot(st,vec2(269.5,183.3)) 
    );

    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
	
	vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(
        mix(
            dot(random(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), 
            dot(random(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), 
            u.x
        ),
        mix(
            dot(random(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), 
            dot(random(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), 
            u.x
        ),
        u.y
    );
}

mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    vec2 pos = vec2(st) * vec2(10.0, st.y * 1.0);
    
    pos = rotate2d( noise(pos + vec2(0.0, u_time * 0.4)) ) * pos;
    
    vec3 color = mix(vec3(0.4157, 0.2196, 0.5451), vec3(1.0), noise(pos) *.5 + .5);

    gl_FragColor = vec4(color, 1.0);
}