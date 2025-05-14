FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    cmake

RUN curl -L --output Open3D-0.18.0.tar.gz https://github.com/isl-org/Open3D/archive/refs/tags/v0.18.0.tar.gz && \
    tar xfz Open3D-0.18.0.tar.gz

RUN cd Open3D-0.18.0 && mkdir build && cd build && cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_PYTHON_MODULE=OFF \
    -DBUILD_WEBRTC=OFF \
    -DBUILD_CUDA_MODULE=ON -DBUILD_COMMON_CUDA_ARCHS=OFF -DCMAKE_CUDA_ARCHITECTURES="75-real;86" \
    -DCMAKE_CUDA_HOST_COMPILER=/usr/bin/g++-10 \
    -DGLIBCXX_USE_CXX11_ABI=ON && \
    make -j"$(nproc)"
