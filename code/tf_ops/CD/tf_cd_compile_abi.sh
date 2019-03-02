#!/usr/bin/env bash
nvcc=/usr/local/cuda-8.0/bin/nvcc
cudalib=/usr/local/cuda-8.0/lib64/
#TF_INC=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
#TF_LIB=$(python3 -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')


$nvcc tf_nndistance_g.cu -c -o tf_nndistance_g.cu.o -std=c++11  -I $TF_INC -DGOOGLE_CUDA=1\
 -x cu -Xcompiler -fPIC -O2 -D_GLIBCXX_USE_CXX11_ABI=0 

g++ tf_nndistance.cpp tf_nndistance_g.cu.o -o tf_nndistance_so.so -std=c++11 -shared -fPIC -I $TF_INC \
-I$TF_INC/external/nsync/public -L$TF_LIB -L/home/peterzhefu/venv/lib/python2.7/site-packages/tensorflow -lcudart -L $cudalib -D_GLIBCXX_USE_CXX11_ABI=0 
