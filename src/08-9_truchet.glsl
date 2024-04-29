#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;

vec2 rotate2D (vec2 _st, float _angle) {
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(.0);

    float columns = 3.0;
    float rows = 3.0;

    st *= vec2(columns, rows);
    st = fract(st);
    st = rotate2D(st, PI);

    // subdivide
    st = vec2(st.x * 2.0, st.y * 2.0);

    // offset
    vec2 cell = floor(st);
    float index = mod(cell.x, 2.0) + mod(cell.y, 2.0) * 2.0;

    // Use mix to select the correct rotation value
    float rotation = mix(0.0, PI * 0.5, step(1.0, index));
    rotation = mix(rotation, PI * -0.5, step(2.0, index));
    rotation = mix(rotation, PI, step(3.0, index));

    // Apply the rotation
    st = rotate2D(st, rotation);

    // normalize
    st = fract(st);

    float mask = step(st.x, st.y);

    color = vec3(mask);
	gl_FragColor = vec4(color, 1.0);
}
