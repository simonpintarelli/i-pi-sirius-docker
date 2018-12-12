#!/bin/bash

git clone --recursive https://github.com/simonpintarelli/SIRIUS.git -b python27_i-PI
(
    cd SIRIUS
    mkdir -p external && \
        python3 prerequisite.py $(realpath external) spg


    mkdir -p build && \
        (
            # make sure SIRIUS finds SPG, other libs are in standard path
            export LIBSPGROOT=/opt/sirius/SIRIUS/external

            cd build
            cmake -DCMAKE_BUILD_TYPE=Release \
                  -DCREATE_PYTHON_MODULE=On \
                  ../
            make install && rm -rf build && \
                echo "Installed SIRIUS binaries to /usr/local/bin"
            echo "TODO set PYTHONPATH"
        )
)
