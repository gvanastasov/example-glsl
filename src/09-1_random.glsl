#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

float curve(vec2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

float lerp(float value1, float value2, float progress) {
    return mix(value1, value2, progress);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    st *= 4.0;

    vec2 cell = floor(st);
    float index = mod(cell.y, 4.0);

    float factor = lerp(1.0, 1000.0, fract(u_time * 0.05)); 

    /*
        we 'fracture'/tear the sine wave value to extend where it no longer
        looks like a wave function - fract(sine(d) * 1000000.0)

        we can still see some crests at the min and max wave values

        the generated value is deterministic, aka no matter how many times
        we compute it - it will be the same - hence the animation looping is
        always the same.
    */
    float randX = fract(((sin((st.x - 0.5) * PI) + 1.0) ) * factor);
 
    /*
        changing the curve will yield different
        concentration of fractures/artefacts.
    */
    randX = mix(randX, sqrt(randX), step(1.0, index));
    randX = mix(randX, randX * randX, step(2.0, index));
    randX = mix(randX, pow(randX, 5.0), step(3.0, index));

    vec2 plot = vec2(randX, st.y - (index));

    float c = curve(plot);

    vec3 color = vec3(c);

    gl_FragColor = vec4(color, 1.0);
}