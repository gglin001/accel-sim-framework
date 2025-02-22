###############################################################################

args=(
  --help
)
util/job_launching/run_simulations.py "${args[@]}"

###############################################################################

# check `short-tests.sh`

args=(
  -C QV100-SASS
  -B rodinia_2.0-ft
  -N myTest
  -T _demos/data/hw_run/rodinia_2.0-ft/9.1
)
source gpu-simulator/gpgpu-sim_distribution/setup &&
  util/job_launching/run_simulations.py "${args[@]}"

###############################################################################
