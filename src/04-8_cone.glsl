#ifdef GL_ES
    precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;

void main(){
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x);

    float grad = (angle/TWO_PI)+0.5;

    vec3 color = vec3(grad);

    gl_FragColor = vec4(color,1.0);
}