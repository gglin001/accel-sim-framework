###############################################################################

mkdir -p _demos/tmp

# rm _demos/tmp/gpgpusim.config
ln -s $PWD/gpu-simulator/gpgpu-sim_distribution/configs/tested-cfgs/SM86_RTX3070/gpgpusim.config \
  $PWD/_demos/tmp/gpgpusim.config

# from `nvbit_release`
cp _demos/data/nvbit_release/test-apps/vectoradd/vectoradd.cu _demos/tmp/main.cu

#####

pushd _demos/tmp
# compile
nvcc main.cu -O0 -g -arch=sm_86 -lcudart -o main
# nvcc main.cu -O3 -arch=sm_86 -lcudart -o main
ldd main
# ./main
popd

pushd _demos/tmp
cuobjdump --all-fatbin --dump-elf ./main >dump-elf.log
cuobjdump --all-fatbin --dump-sass ./main >dump-sass.log
cuobjdump --all-fatbin --dump-ptx ./main >dump-ptx.log
cuobjdump --all-fatbin --extract-elf all ./main
cuobjdump --all-fatbin --extract-ptx all ./main
cuobjdump --all-fatbin --extract-text all ./main
popd

#####

pushd _demos/tmp
echo "ACCELSIM_ROOT: $ACCELSIM_ROOT"
LD_LIBRARY_PATH="$ACCELSIM_ROOT/../build/gpgpu-sim_distribution" ./main \
  2>&1 0>&1 | tee gpgpu-sim_distribution.log
popd

###############################################################################
