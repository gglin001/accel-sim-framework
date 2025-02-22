###############################################################################

# work in docker container
https://github.com/gglin001/Dockerfiles/tree/main/accel-sim-framework

###############################################################################

git clone git@github.com:accel-sim/gpgpu-sim_distribution.git gpu-simulator/gpgpu-sim_distribution
# git clone git@github.com:gglin001/gpgpu-sim_distribution.git gpu-simulator/gpgpu-sim_distribution

git clone --depth 1 -b master https://github.com/pybind/pybind11.git gpu-simulator/extern/pybind11

###############################################################################

cmake --preset osx -Sgpu-simulator

cmake --build build
cmake --build build --target install

###############################################################################
