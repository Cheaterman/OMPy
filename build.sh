#!/bin/sh
if [ ! -e build ]; then
    mkdir build
    (
        export \
            CC=$(which clang) \
            CXX=$(which clang++) \
        &&
        cd build &&
        cmake .. \
            -G Ninja \
            -DCMAKE_C_FLAGS=-m32 \
            -DCMAKE_CXX_FLAGS=-m32 \
            -DCMAKE_BUILD_TYPE=Debug \
        ;
    )
fi

cmake --build build --config Debug
