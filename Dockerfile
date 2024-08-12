ARG COMPILER_VARIANT_IMAGE
FROM $COMPILER_VARIANT_IMAGE

LABEL org.opencontainers.image.authors="Shiv Upadhyay <shivnupadhyay@gmail.com>"

SHELL ["/bin/bash", "-l", "-i", "-c"]
ENV SHELL=/bin/bash

ENV HOME=/root
WORKDIR "$HOME"

ARG COMPILER_VARIANT
RUN apt-get -y update && apt-get install apt-transport-https ca-certificates -y && update-ca-certificates
RUN apt-get install -y -qq --no-install-recommends \
      build-essential \
      cmake \
      libeigen3-dev \
      ninja-build \
      curl \
      jq \
      libssl-dev \
      libffi-dev \
      python3 \
      python3-venv \
      python3-dev \
      python3-pip \
      git
RUN if [[ 'GCC' == *$COMPILER_VARIANT* ]]; then apt-get install -y -qq --no-install-recommends gcc-12 libopenblas64-openmp-dev; fi
RUN if [[ 'MPICH' == *$COMPILER_VARIANT* ]]; then apt-get install -y -qq --no-install-recommends mpich libmpich-dev libscalapack-mpich-dev; fi
RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/xsligroup/libint-cq.git
WORKDIR "$HOME"/libint-cq

RUN mkdir -p build && cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -S . -B ./build && cmake --build ./build && cmake --build ./build --target install
RUN rm -rf "$HOME"/libint-cq
