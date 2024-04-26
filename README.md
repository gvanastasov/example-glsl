# example-glsl

## Development (VSCode)

1. Install language support for VSCode - [https://marketplace.visualstudio.com/items?itemName=slevesque.shader](Shader languages support for VS Code).
2. Install GLSL live preview for VSCode - [https://marketplace.visualstudio.com/items?itemName=circledev.glsl-canvas](glsl-canvas)
3. Install linter - [https://marketplace.visualstudio.com/items?itemName=dtoplak.vscode-glsllint](GLSL Lint)
    - herein the linter might require extra bit of work - you would need to probably download the [https://github.com/KhronosGroup/glslang](https://github.com/KhronosGroup/glslang), get proper release version for your machine and update the extension setting `glsllint.glslangValidatorPath` to point at the `bin\glslangValidator.exe` from the release binaries
4. Add GLSL snippets - [https://marketplace.visualstudio.com/items?itemName=j0hnm4r5.glsl-snippets](glsl-snippets)

## Topics

1. Whats glsl?
2. Whats fragment shader?

## Shaders

1. [Hello World](./src/01_hello_world.glsl)
2. [Uniforms](./src/02_uniforms.glsl)
3. Screen Coords
    - [Normalized](./src/03_screen_coords.glsl)
    - [Mouse](./src/03-1_mouse_coords.glsl)
4. Algorithmic Drawing
    - [Diagonal](./src/04_algorithmic_diagonal.glsl)
    - [Curve](./src/04-1_algorithmic_curve.glsl)
    - [Edge](./src/04-2_algorithmic_edge.glsl)
    - [Sine Wave](./src/04-3_algorithmic_sin.glsl)
    - [Cosine Wave](./src/04-4_algorithmic_cos.glsl)
    - [Circle/Cursor](./src/04-5_algorithmic_cursor.glsl)
    - [Function Area](./src/04-6_algorithmic_area.glsl)
    - [Polar Coords](./src/04-7_polar_coords.glsl)
    - [Cone](./src/04-8_cone.glsl)
5. Colors
    - [Mix](./src/05_mixing_colors.glsl)
    - [Channels](./src/05-1_mixing_channels.glsl)
    - [Day-Night Animation](./src/05-2_mixing_painting.glsl)
    - [Rainbow](./src/05-3_rainbow.glsl)
    - [Country Flags](./src/05-4_flag.glsl)
    - [HSB angle](./src/05-5_hsb.glsl)
6. Shapes
    - [Square Mask](./src/06_shape_square_mask.glsl) - sharp, smooth, outline


## Credits
based on [The Book of Shaders](https://thebookofshaders.com/)