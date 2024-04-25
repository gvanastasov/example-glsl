#ifdef GL_ES
    precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;

void main(){
    vec2 st = gl_FragCoord.xy / u_resolution;

    vec2 toCenter = vec2(0.5) - st;
    float radius = length(toCenter) * 2.0;

    vec3 color = vec3(radius);

    gl_FragColor = vec4(color,1.0);
}