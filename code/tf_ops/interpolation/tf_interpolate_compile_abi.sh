#!/usr/bin/env bash
nvcc=/usr/local/cuda-8.0/bin/nvcc
cudalib=/usr/local/cuda-8.0/lib64/
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

g++ tf_interpolate.cpp -o tf_interpolate_so.so -std=c++11  -shared -fPIC -I $TF_INC  \
-I$TF_INC/external/nsync/public -L$TF_LIB -L/home/peterzhefu/venv/lib/python2.7/site-packages/tensorflow -lcudart -L $cudalib -O2 -D_GLIBCXX_USE_CXX11_ABI=0
