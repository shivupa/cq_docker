#!/bin/bash

docker build -t shivupa/GCC12_NoMPI:latest --build-arg COMPILER_VARIANT_IMAGE="ubuntu:22.04" --build-arg COMPILER_VARIANT="GCC12_NoMPI" .
docker build -t shivupa/GCC12_MPICH:latest --build-arg COMPILER_VARIANT_IMAGE="ubuntu:22.04" --build-arg COMPILER_VARIANT="GCC12_MPICH" .
docker build -t shivupa/IntelOneAPI_NoMPI:latest --build-arg COMPILER_VARIANT_IMAGE="intel/oneapi:2024.2.0-1-devel-ubuntu22.04" --build-arg COMPILER_VARIANT="IntelOneAPI_NoMPI" .
