###############################################################################

args=(
  --help
)
util/job_launching/run_simulations.py "${args[@]}"

###############################################################################

# check `short-tests.sh`
# check `util/job_launching/README.md`

args=(
  -B rodinia_2.0-ft
  -C QV100-SASS
  -N rodinia-sass-test
  -l local
  # downloaded data
  -T _demos/data/hw_run/rodinia_2.0-ft/9.1
)
util/job_launching/run_simulations.py "${args[@]}"

# source gpu-simulator/gpgpu-sim_distribution/setup &&
#   util/job_launching/run_simulations.py "${args[@]}"

util/job_launching/job_status.py -N rodinia-sass-test

###############################################################################

args=(
  -B rodinia_2.0-ft
  -C QV100-PTX
  -N rodinia-ptx-test
  -l local
  # downloaded data
  -T _demos/data/hw_run/rodinia_2.0-ft/9.1
)
util/job_launching/run_simulations.py "${args[@]}"

# source gpu-simulator/gpgpu-sim_distribution/setup &&
#   util/job_launching/run_simulations.py "${args[@]}"

util/job_launching/job_status.py -N rodinia-ptx-test

###############################################################################

args=(
  -config ./gpgpusim.config
  -trace ./traces/kernelslist.g
)
pushd sim_run_12.8/backprop-rodinia-2.0-ft/4096___data_result_4096_txt/QV100-PTX
accel-sim.out "${args[@]}"
popd

###############################################################################

# no `run_simulations.py`

mkdir -p _demos/tmp
cp -r _demos/data/hw_run/rodinia_2.0-ft/9.1/backprop-rodinia-2.0-ft/4096___data_result_4096_txt/traces _demos/tmp/
cat gpu-simulator/gpgpu-sim_distribution/configs/tested-cfgs/SM7_QV100/gpgpusim.config >_demos/tmp/gpgpusim.config
#
printf "\n#PTX" >>_demos/tmp/gpgpusim.config
printf "\n#PTX-Driven GPGPU-Sim\n" >>_demos/tmp/gpgpusim.config
# or
# printf "\n#SASS" >>_demos/tmp/gpgpusim.config
# printf "\n#SASS-Driven Accel-Sim\n" >>_demos/tmp/gpgpusim.config
#
cat gpu-simulator/configs/tested-cfgs/SM7_QV100/trace.config >>_demos/tmp/gpgpusim.config

args=(
  -config ./gpgpusim.config
  -trace ./traces/kernelslist.g
)
pushd _demos/tmp
accel-sim.out "${args[@]}" 2>&1 0>&1 | tee accel-sim.out.log
popd

###############################################################################
