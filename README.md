# MNIST Classifier - A WebAssembly BLAS Demo

A handwritten digit classifier demonstrating BLAS routines running in a web browser using WebAssembly.

Forked from https://github.com/georgestagg/mnist-classifier-blas-wasm. Read the README there for details about the project.

This repository differs from the original project with respect to the `mnist.js` and `mnist.wasm` files used. The original author used [LLVM-Flang](https://github.com/llvm/llvm-project/tree/main/flang) compiler (with hacks) to generate these files. Here in this repository we generate these files with the [LFortran](https://github.com/lfortran/lfortran) compiler (No hacks).

LFortran used is https://github.com/lfortran/lfortran/tree/26c7a7976708f2d595a0ab64f0d531b43518f200.

```console
% lfortran --version
LFortran version: 0.35.0-62-g26c7a7976-dirty
Platform: macOS ARM
Default target: arm64-apple-darwin22.4.0
```

Steps to generate `mnist.js` and `mnist.wasm`:

```console
lfortran -c classifier.f90 --generate-object-code --rtlib --target=wasm32-unknown-emscripten

emcc --target=wasm32-unknown-emscripten -sSTACK_SIZE=50mb -sINITIAL_MEMORY=256mb -o www/mnist.js classifier.o <path-to-lfortran-runtime-library>/lfortran_runtime_wasm_emcc.o --no-entry -sEXPORTED_FUNCTIONS=_classifier,_malloc,_free
```

# Interactive Website

Draw a digit from 0-9 in the box and the classifier will try to label the handwritten digit. The resulting relative probabilities will be shown in a plot on the right.

https://shaikh-ubaid.github.io/mnist-classifier-blas-wasm/
