#!/bin/bash

git clone --recursive https://github.com/electronic-structure/SIRIUS.git -b develop
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
            echo 'export PYTHONPATH=/usr/local/lib/python3.6/site-packages:${PYTHONPATH}' >> /etc/bash.bashrc
        )
)
