#ifdef GL_ES
    precision mediump float;
#endif

uniform vec2 u_resolution;

/*
    Mouse position in pixels
*/
uniform vec2 u_mouse;

void main() {
    /*
        substraction of the mouse position to the current pixel position
        causes to move the center of the coordinate system to the mouse position
        aka black color (0.0, 0.0, 0.0) at the mouse position
    */
    vec2 st = (gl_FragCoord.xy - u_mouse) / u_resolution;
    gl_FragColor = vec4(st.x, st.y, 0.0, 1.0);
}