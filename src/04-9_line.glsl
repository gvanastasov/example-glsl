#ifdef GL_ES
    precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;

float line(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

void main(){
    vec2 st = gl_FragCoord.xy / u_resolution;

    float d = line(st, vec2(0.0), vec2(1.0));
    d = smoothstep(0.005, 0.001, d);

    float d2 = line(st, vec2(1.0, 0.0), vec2(0.0, 1.0));
    d2 = smoothstep(0.005, 0.001, d2);

    vec3 color = vec3(d) + vec3(d2);

    gl_FragColor = vec4(color, 1.0);
}