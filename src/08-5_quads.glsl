#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265358979323846

uniform vec2 u_resolution;
uniform float u_time;

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

float maskRectSmooth(in vec2 space, in vec2 center, in vec2 size, float feather) {
    vec2 dist = abs(space - center) - size * 0.5;
    return smoothstep(feather, 0.0, max(dist.x, dist.y));
}

vec2 scale(vec2 _st, vec2 _scale) {
    _st -= 0.5;
    _st = mat2(_scale.x, 0.0,
                0.0, _scale.y) * _st;
    _st += 0.5;
    return _st;
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;

    st = tile(st, 4.);
    st = rotate2D(st, 2.0 * PI * 0.25 * fract(u_time * 0.5));
    st = scale(st, vec2(2.0) + sin(u_time));

    float quad = maskRectSmooth(st, vec2(0.5), vec2(0.7), 0.01);

    vec3 color = vec3(0.0);
    color = vec3(quad * (1. - sin(u_time)));

	gl_FragColor = vec4(color, 1.0);
}
