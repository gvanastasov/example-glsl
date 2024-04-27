#ifdef GL_ES
    precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius-feather, radius, dot(dist,dist) * 4.0);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float line(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

void main(){
    vec2 st = gl_FragCoord.xy / u_resolution;

    float radar = maskCircle(st, vec2(0.5), 0.5, 0.0);

    float ring = maskCircle(st, vec2(0.5), 0.5, 1.);

    ring = 
        (step(ring, 0.0002) - step(ring, 0.00)) + 
        (step(ring, 0.207) - step(ring, 0.2)) + 
        (step(ring, 0.403) - step(ring, 0.4));

    float dg1 = line(st, vec2(0.0), vec2(1.0));
    dg1= smoothstep(0.0015, 0.001, dg1);

    float dg2 = line(st, vec2(1.0, 0.0), vec2(0.0, 1.0));
    dg2 = smoothstep(0.0015, 0.001, dg2);

    vec2 armSpace = st - vec2(0.5);
    armSpace = rotate2d(fract(u_time * - 0.2) * TWO_PI) * armSpace;
    armSpace += vec2(0.5);

    vec2 a = vec2(0.5);
    vec2 b = vec2(1.0, 0.5);

    float d = line(armSpace, a, b);
    d = 1.0 - smoothstep(0.001, 0.005, d);

    vec2 toCenter = vec2(0.5) - armSpace;
    float angle = atan(toCenter.y, toCenter.x);

    float arm = smoothstep(0.25, 0.00, (angle/TWO_PI) + 0.5);

    vec4 armColor = vec4(0.27, 0.5, 0.5, 0.13) * arm;
    vec4 dotColor = vec4(0.0, 0.56, 0.58, 1.0) * d;
    vec4 dgColor = vec4(0.17, 0.17, 0.17, 1.0);
    vec4 ringColor = vec4(0.49, 0.82, 0.82, 1.0);

    armColor += dotColor;

    vec4 color = vec4(0.0) * radar;
    color = mix(color, dgColor, (dg1 + dg2) * radar);
    color = mix(color, armColor, arm * radar);
    color = mix(color, ringColor, ring);

    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0) + color;
}