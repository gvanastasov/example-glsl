#ifdef GL_ES
    precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;

float maskCircle(in vec2 space, in vec2 pos, in float radius, in float feather) {
    vec2 dist = pos - space;
    return 1.0 - smoothstep(radius-feather, radius, dot(dist,dist) * 4.0);
}

float maskCircleLine(in vec2 space, in vec2 pos, in float radius, in float feather, in float width) {
    return maskCircle(space, pos, radius, feather) - maskCircle(space, pos, radius - width, feather);
}

float maskRect(in vec2 space, in vec2 center, in vec2 size) {
    vec2 dist = abs(space - center) - size * 0.5;
    return step(max(dist.x, dist.y), 0.0);
}

float maskCross(vec2 st, in vec2 center, in float thickness, in float size) {
    return
        maskRect(st, center, vec2(thickness, size)) + 
        maskRect(st, center, vec2(size, thickness));
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

void main() {
	vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    float columns = 3.0;
    float rows = 3.0;

    st = vec2(st.x * columns, st.y * rows);
    vec2 grid = fract(st);
    vec2 cell = floor(st);

    float circle = maskCircleLine(grid, vec2(0.5), 0.2, 0.01, 0.1);

    vec2 cst = grid - vec2(0.5);
    cst = rotate2d(PI * 0.25) * cst;
    cst += vec2(0.5);
    float cross = maskCross(cst, vec2(0.5, 0.5), 0.5, 0.1);

    cell.x = cell.x / columns;
    cell.y = cell.y / rows;

    float state = mod(cell.x + cell.y, 2.0);

    /*
        switch the two shapes based on step function
    */
    color = vec3(cross * step(0.7, state) + circle * step(state, 0.7));

	gl_FragColor = vec4(color, 1.0);
}
