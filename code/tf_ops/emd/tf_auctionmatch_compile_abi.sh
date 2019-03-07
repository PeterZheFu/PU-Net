#!/usr/bin/env bash
nvcc=/usr/local/cuda/bin/nvcc
cudalib=/usr/local/cuda/lib64/
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

$nvcc tf_auctionmatch_g.cu  -c -o tf_auctionmatch_g.cu.o -D_GLIBCXX_USE_CXX11_ABI=0  -std=c++11  -I $TF_INC -DGOOGLE_CUDA=1\
 -x cu -Xcompiler -fPIC -O2 -arch=sm_30

g++ tf_auctionmatch.cpp tf_auctionmatch_g.cu.o -o tf_auctionmatch_so.so -std=c++11 -shared -fPIC -I $TF_INC \
-I$TF_INC/external/nsync/public -L$TF_LIB -L/home/peterzhefu/venv/lib/python2.7/site-packages/tensorflow -lcudart -L $cudalib -D_GLIBCXX_USE_CXX11_ABI=0  
