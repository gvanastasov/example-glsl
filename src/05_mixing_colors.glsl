#ifdef GL_ES
    precision mediump float;
#endif

uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void main() {
    vec3 color = vec3(0.0);

    /*
        pct = 0.0 -> color = colorA
        pct = 1.0 -> color = colorB

        since we use abs(sin(u_time)) the value will 
        oscillate between 0.0 and 1.0 (progress as percetage) and
        then back to 0.0 (and so on...) in a smooth way (sin wave)
    */
    float pct = abs(sin(u_time));

    color = mix(colorA, colorB, pct);

    gl_FragColor = vec4(color,1.0);
}