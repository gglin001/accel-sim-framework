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
  # downloaded data
  -T _demos/data/hw_run/rodinia_2.0-ft/9.1
)
source gpu-simulator/gpgpu-sim_distribution/setup &&
  util/job_launching/run_simulations.py "${args[@]}"

util/job_launching/job_status.py -N rodinia-sass-test

###############################################################################

args=(
  -B rodinia_2.0-ft
  -C QV100-PTX
  -N rodinia-ptx-test
  # downloaded data
  -T _demos/data/hw_run/rodinia_2.0-ft/9.1
)
source gpu-simulator/gpgpu-sim_distribution/setup &&
  util/job_launching/run_simulations.py "${args[@]}"

util/job_launching/job_status.py -N rodinia-ptx-test

###############################################################################
