#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

vec2 random (vec2 st) {
    // We generate a random vector for each cell by using the dot product of the cell index
    // and two prime numbers. This will give us a random gradient vector for each cell.
    st = vec2( 
        dot(st,vec2(127.1,311.7)),
        dot(st,vec2(269.5,183.3)) 
    );

    // since we are dealing with vector values and not color values, we need to
    // move the random values to the range of -1 to 1.
    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
	
	vec2 u = f * f * (3.0 - 2.0 * f);

    // Instead of getting a value at the corners of each cell, we get the value at 
    // the center of the cell. Since the computation relies on the 'index' position
    // we will get gradient value for neighboring cells at the same time.
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

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    vec2 pos = vec2(st * 100.0);

    vec3 color = vec3(noise(pos) *.5 + .5);

    gl_FragColor = vec4(color, 1.0);
}