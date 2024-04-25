#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorSky = vec3(0.34, 0.52, 0.59);
vec3 colorSkyAtten = vec3(1.000,0.833,0.224);
vec3 colorNight = vec3(0.07, 0.07, 0.15);
vec3 colorNightAtten = vec3(0.26, 0.29, 0.7);

vec3 colorWater = vec3(0.15, 0.27, 0.38);
vec3 colorSun = vec3(1.0, 0.65, 0.0);

float curve(vec2 st){
    return smoothstep(0.01, 0.0, abs(st.y - st.x));
}

float circle(vec2 st, vec2 center, float radius) {
    vec2 dist = st - center;
    return length(dist) - radius;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    float sunX = 0.8 + cos(u_time) * 0.3;
    float sunY = 0.3 + sin(u_time) * 0.3;

    // add sky color
    vec3 color = mix(
        mix(colorSky, colorSkyAtten, pow(st.y, 2.0)),
        mix(colorNightAtten, colorNight, pow(st.y, 2.0)),
        sunX
    );

    // add sun halo
    color = mix(colorSun * 0.5, color, smoothstep(0.0, .30, circle(st, vec2(sunX, sunY), 0.02)));

    // add sun
    color = mix(
        colorSun, 
        color, 
        step(0.0, circle(st, vec2(sunX, sunY), 0.02)));

    // add water color
    color = mix(
        // sky reflection
        mix(colorSky, colorWater, smoothstep(0.3, 0.0, st.y)), 
        color, 
        step(0.3, st.y));

    gl_FragColor = vec4(color,1.0);
}
