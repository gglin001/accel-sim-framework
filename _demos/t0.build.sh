###############################################################################

git clone git@github.com:accel-sim/gpgpu-sim_distribution.git gpu-simulator/gpgpu-sim_distribution
# git clone git@github.com:gglin001/gpgpu-sim_distribution.git gpu-simulator/gpgpu-sim_distribution

# work in docker container
docker pull nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

###############################################################################

# colima proxy for macos
# export http_proxy=http://host.lima.internal:10800
# export https_proxy=http://host.lima.internal:10800

apt update

# install micromamba
apt install curl
curl -LO micro.mamba.pm/install.sh
bash install.sh
rm install.sh

# micromamba env
micromamba create -n pyenv python=3.12 -y
echo "micromamba activate pyenv" >>~/.bashrc

apt install bc
pip install cmake ninja
micromamba install git bison

# micromamba install pkg-config
# micromamba install zlib
# apt update
apt install libz-dev
# apt install libgl-dev

git clone --depth 1 -b master https://github.com/pybind/pybind11.git gpu-simulator/extern/pybind11

###############################################################################

cmake --preset osx -Sgpu-simulator

cmake --build build
cmake --build build --target install

###############################################################################
