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
3. [Screen Coords](./src/03_screen_coords.glsl)

## Credits
based on [The Book of Shaders](https://thebookofshaders.com/)