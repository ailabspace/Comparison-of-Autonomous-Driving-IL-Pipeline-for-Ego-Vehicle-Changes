#!/bin/bash

export ROOTDIR=${1:-/opt/carla-simulator}

export TRAINING_ROOT=${ROOTDIR}/CILv2_multiview
export DRIVING_TEST_ROOT=${TRAINING_ROOT}/run_CARLA_driving
export SCENARIO_RUNNER_ROOT=${TRAINING_ROOT}/scenario_runner/
export TRAINING_RESULTS_ROOT=${TRAINING_ROOT}/results
export SENSOR_SAVE_PATH=${TRAINING_ROOT}/sensor_frames

export CARLA_SERVER=${ROOTDIR}/CarlaUE4.sh
export PYTHONPATH=$PYTHONPATH:${ROOTDIR}/PythonAPI
export PYTHONPATH=$PYTHONPATH:${ROOTDIR}/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:${ROOTDIR}/PythonAPI/carla/dist/carla-0.9.13-py3.7-linux-x86_64.egg
export PYTHONPATH="${ROOTDIR}/PythonAPI/carla/":$TRAINING_ROOT:$DRIVING_TEST_ROOT:$SCENARIO_RUNNER_ROOT
export PYTHONPATH="${ROOTDIR}/PythonAPI/carla/":"${TRAINING_ROOT}":"${DRIVING_TEST_ROOT}":"${SCENARIO_RUNNER_ROOT}":${PYTHONPATH}


# To run Town05 leaderboard driving test for trained CIL++ agent

leaderboard_Town05_cilv2 () {
    python ${DRIVING_TEST_ROOT}/driving/evaluator.py \
    --debug=0 \
    --scenarios=${DRIVING_TEST_ROOT}/data/leaderboard/leaderboard_Town05.json  \
    --routes=${DRIVING_TEST_ROOT}/data/leaderboard \
    --repetitions=1 \
    --resume=True \
    --track=SENSORS \
    --agent=${DRIVING_TEST_ROOT}/driving/autoagents/CILv2_agent.py \
    --checkpoint=${DRIVING_TEST_ROOT}/results/leaderboard1  \
    --agent-config=${TRAINING_RESULTS_ROOT}/_results/Ours/Town12346_5/config40.json \
    --gpus=0 \
    --fps=20 \
    --PedestriansSeed=0 \
    --trafficManagerSeed=0 \
    # --save-driving-vision # uncomment to save frames
}

function_array=("leaderboard_Town05_cilv2")

# resume benchmark in case carla is crashed, until the benchmark is finished
RED=$'\e[0;31m'
NC=$'\e[0m'
for run in "${function_array[@]}"; do
    PYTHON_RETURN=1
    until [ $PYTHON_RETURN == 0 ]; do
      ${run}
      PYTHON_RETURN=$?
      echo "${RED} PYTHON_RETURN=${PYTHON_RETURN}!!! Start Over!!!${NC}" >&2
      sleep 2
    done
    sleep 2
done

echo "Bash script done."