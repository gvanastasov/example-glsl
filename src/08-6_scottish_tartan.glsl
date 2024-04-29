#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265358979323846

uniform vec2 u_resolution;

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}


float maskRectSmooth(in vec2 space, in vec2 center, in vec2 size, float feather) {
    vec2 dist = abs(space - center) - size * 0.5;
    return smoothstep(feather, 0.0, max(dist.x, dist.y));
}

float maskRect(in vec2 space, in vec2 center, in vec2 size) {
    vec2 dist = abs(space - center) - size * 0.5;
    return step(max(dist.x, dist.y), 0.0);
}

float maskCross(vec2 st, in vec2 center, in float thickness, in float size) {
    return
        maskRect(st, center, vec2(thickness, size)) + 
        maskRect(st, center, vec2(size, thickness));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    st = rotate2D(st, PI / 4.0);

    st = st * 4.0;

    vec2 cell = floor(st);
    vec2 isOdd = mod(cell, 2.0);

    st = fract(st);
    float cross = mix(step(0.485, st.y) - step(0.515, st.y), maskCross(st, vec2(0.5), 1.0, 0.03), abs(1. - isOdd.x));

    st = st * 4.0;
    vec2 cell2 = floor(st);
    float isOdd2 = mod(cell2.x, 2.0);

    st = st * 8.0;
    vec2 cell3 = floor(st);

    // base
    vec3 color = vec3(0.0);

    // row stripes
    color = mix(vec3(.3), vec3(0.5), isOdd.y);
    
    // x sub division stripes
    color = mix(
        color,
        mix(vec3(0.0),vec3(0.3), ceil(cell2.x / 16.0) * isOdd.x * isOdd2),
        isOdd.x
    );

    // intersection sub division stripes
    color += mix(
        color,
        mix(vec3(0.3),vec3(0.5), ceil(cell2.y / 16.0) * isOdd.y * mod(cell2.y, 2.0)),
        isOdd.y * isOdd.x
    );

    // y sub division stripes
    color = mix(
        color,
        mix(vec3(0.0),vec3(1.0), ceil(cell2.y / 16.0) * isOdd.y * mod(cell2.y, 2.0)),
        isOdd.y - isOdd.x
    );
    
    // line crossings
    color = mix(color, vec3(1.0, 0.0, 0.0), cross);

    // linen dots
    vec3 c = mix(vec3(0.0), vec3(1.0), mod(cell3.x, 2.0) + mod(cell3.y, 2.0));

    // lerp between final color and dots
    color = mix(color, color * c, 0.8);

	gl_FragColor = vec4(color, 1.0);
}
