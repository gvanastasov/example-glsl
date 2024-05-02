#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

vec2 skew (vec2 st) {
    vec2 r = vec2(0.0);
    r.x = 1.1547 * st.x;
    r.y = st.y + 0.5 * r.x;
    return r;
}

vec3 simplexGrid (vec2 v) {
    vec3 xyz = vec3(0.0);

    vec2 p = fract(skew(v));
    if (p.x > p.y) {
        xyz.xy = 1.0-vec2(p.x,p.y-p.x);
        xyz.z = p.y;
    } else {
        xyz.yz = 1.0-vec2(p.x-p.y,p.y);
        xyz.x = p.x;
    }

    vec3 coords = fract(xyz);
    
    // compute the gradient vector based on 3 corners 
    // instead of 4 to optimize the algorithm
    vec3 grad = 0.5 - abs(coords - 0.5);
    vec3 n = normalize(grad);
    return n;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st *= 10.;

    vec3 color = simplexGrid(st);

    gl_FragColor = vec4(color,1.0);
}