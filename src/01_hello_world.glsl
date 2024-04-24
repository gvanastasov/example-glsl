// preprocessor directive
#ifdef GL_ES
    // configure floating point behaviour during computation
    precision mediump float;
#endif

// single (mandatory) main function
void main() {
    /*
        1. final pixel color
    
        2. vec4 reserved type for 4D vector
    
        3. remember to use . for floating points, as 
        type casting is not supported on all devices

        4. assigning to global reserved variable
    */
    gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0);
}