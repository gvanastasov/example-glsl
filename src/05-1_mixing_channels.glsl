#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float curve(vec2 st){
    return smoothstep(0.01, 0.0, abs(st.y - st.x));
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec2 plot = vec2(st.x, st.y);
    
    vec3 d = vec3(
        curve(vec2(smoothstep(0.0,1.0, plot.x), plot.y)),
        curve(vec2(sin(plot.x*PI), plot.y)),
        curve(vec2(pow(plot.x,0.5), plot.y))
    );
    
    vec3 color = vec3(0.0);

    // mix the grad color
    color = mix(colorA, colorB, plot.x);

    // mix the curve channel color
    color = mix(color,vec3(colorB.r,0.0,0.0),d.r);
    color = mix(color,vec3(0.0,colorB.g,0.0),d.g);
    color = mix(color,vec3(0.0,0.0, colorB.b),d.b);

    gl_FragColor = vec4(color,1.0);
}
