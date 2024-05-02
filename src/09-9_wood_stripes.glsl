#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

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

float lines(in vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(
        0.0,
        0.5 + b * 0.5,
        abs((sin(pos.x * 3.1415 ) + b * 2.0)) * 0.5
    );
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    vec2 pos = st.xy * vec2(10.0, 3.0);
    
    float pattern = pos.x;

    pos = rotate2d( noise(pos) ) * pos;
    
    pattern = lines(pos,.5);

    vec3 color = mix(vec3(0.4118, 0.298, 0.2627), vec3(0.1216, 0.0863, 0.0627), pattern);

    gl_FragColor = vec4(color, 1.0);
}