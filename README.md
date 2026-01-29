# A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle

This repository contains source codes and demo video for the experiments in our paper "A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle".

## [Paper](https://ailab.space/wp-content/uploads/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/IV24_0299_FI.pdf) | [Poster](https://ailab.space/wp-content/uploads/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/MoPo2I4.12-Poster.pdf) | [Project Page](https://ailab.space/projects/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/) | [Demo Video](https://www.youtube.com/playlist?list=PLT6vZE-j-Q_txkFGr4UAbPygAfNeKJL9n)

# Contents

1. [Overview and Base Repositories](#overview-and-base-repositories)
2. [Using the Modified Implementations](#using-the-modified-implementations)
3. [Running an Agent](#running-an-agent)
4. [Changing the Ego-Vehicle](#changing-the-ego-vehicle)

# Overview and Base Repositories

This repository provides evaluation implementations of two imitation learning (IL) pipelines for autonomous driving, with the goal of assessing **vehicle adaptability**, i.e. deploying trained autonomous driving models on ego-vehicles with different physical properties **without retraining**.

The experiments are conducted in CARLA by adapting and extending the following public codebases:

- **[TransFuser](https://github.com/autonomousvision/transfuser)**  
  A waypoint-based imitation learning model that uses multi-sensor fusion to predict future waypoints.

- **[CIL++](https://github.com/yixiao1/CILv2_multiview)**  
  A control-based imitation learning model that directly predicts low-level control signals (steering angle, throttle, and brake).

This repository provides the **routes, experiment setup, and evaluation procedure** used in our study, while keeping the **original training and evaluation pipelines** of the base repositories intact.

For installation, training, and evaluation, you can refer to the **original instructions** provided by each repository.

This repository only includes **modifications necessary to enable ego-vehicle changes and synchronized CARLA Leaderboard evaluation for all IL models**.

# Using the Modified Implementations

To use our modified code for evaluation, **replace the corresponding folders in the original repository** with the folders provided in this repository.
> **Warning:** Always back up the original folders before replacing them.

## TransFuser

1. Locate the following directory in the original TransFuser repository:

```
 ./transfuser/leaderboard/data
```

2. Insert the following folders (provided in this repository under `TransFuser/` folder) in the directory:
```
leaderboard_town05/
scenarios/
```

3. The `leaderboard_town05/` folder contains:
* `town05_navigation.xml` route file.

4. The `scenarios/` folder contains:
* `no_scenarios.json` scenario file.

These files were used for all waypoint-based model experiments in this work.

5. Locate the evaluation script (sample available in the `TransFuser/` folder):
```
./transfuser/leaderboard/scripts/local_evaluation.sh
``` 

Update the route and scenario paths as follows:

```
export SCENARIOS=${WORK_DIR}/leaderboard/data/scenarios/no_scenarios.json
export ROUTES=${WORK_DIR}/leaderboard/data/leaderboard_town05/Town05_navigation.xml
```

## CIL++

### Route Scenario

1. Locate the following file in the original CIL++ repository:
```
./CILv2_multiview/run_CARLA_driving/driving/scenarios/route_scenario.py
```

2. Replace the original `route_scenario.py` file with the version provided in this repository (under `cil++/scenarios/` folder).

This modification enables the **CARLA Leaderboard collision criterion**, as the original CIL++ implementation is configured for the **NoCrash** experimental setting.

### Leaderboard Script

1. Locate the following directory in CIL++ repository:
```
./CILv2_multiview/run_CARLA_driving/scripts/run_evaluation/CILv2/
```

2. Insert the script:
```
leaderboard_Town05.sh
``` 
(provided in this repository under `cil++/CILv2/`) into this directory.


### Routes & Scenarios


1. Locate the following directory in CIL++ repository:

```
./CILv2_multiview/run_CARLA_driving/data/leaderboard
```

2. Insert the following files in `leaderboard/` directory (provided in this repository under `cil++/leaderboard/`):

* `leaderboard_Town05.json` — scenario file
* `Town05_navigation.xml` — route file.

These files defined the the Town05 evaluation setup used in our experiments.

3. Locate the evaluation script (sample available in the `cil++/CILv2/` folder):
```
./CILv2_multiview/run_CARLA_driving/scripts/run_evaluation/CILv2/leaderboard_Town05.sh
``` 

Update the route and scenario paths as follows:

```
--scenarios=${DRIVING_TEST_ROOT}/data/leaderboard/leaderboard_Town05.json  \
--routes=${DRIVING_TEST_ROOT}/data/leaderboard \ # it will pick up the xml file without specifying the exact file
```


# Running an Agent

## TransFuser
1. Start the CARLA server:

```
./transfuser/carla/CarlaUE4.sh --world-port=2000 -opengl
```

2. Run the evaluation script:
```
CUDA_VISIBLE_DEVICES=0 ./transfuser/leaderboard/scripts/local_evaluation.sh
```

3. Perform result processing:
The raw evaluation outputs are post-processed using:

```
transfuser/tools/result_parser.py
```

## CIL++

1. Start the CARLA server:

```
./CarlaUE4.sh --world-port=2000 -opengl
```

2. Run the evaluation script:
```
CUDA_VISIBLE_DEVICES=0 ./CILv2_multiview/run_CARLA_driving/scripts/run_evaluation/CILv2/leaderboard_Town05.sh
```

**Note:** Due to variability in CARLA simulation results for both IL models, **each experiment was repeated three times,** and the results were averaged.

# Changing the Ego-Vehicle
To evaluate the performance of the trained models on *different ego-vehicles* in CARLA, follow the instructions below for each pipeline:

## TransFuser

1. Locate the following file:

```
./transfuser/leaderboard/leaderboard/scenarios/route_scenario_local.py
```

2. Find the function:
```
_update_ego_vehicle()
```

3. Modify the vehicle blueprint ID in the following line:

```
 ego_vehicle = CarlaDataProvider.request_new_actor('vehicle.lincoln.mkz2017',
                                                         elevate_transform,
                                                         rolename='hero')
```

For example, replace `vehicle.lincoln.mkz2017` with:
```
'vehicle.toyota.prius'
```

A full list of available vehicle blueprint IDs can be found in the CARLA documentation: 
https://carla.readthedocs.io/en/latest/catalogue_vehicles/

## CIL++

1. Locate the following file:
```
./CILv2_multiview/run_CARLA_driving/data/leaderboard/leaderboard_Town05.json
```

2. Find the line specifying the ego-vehicle blueprint:
```
"vehicle_model": "vehicle.tesla.model3",
```

3. Modify the vehicle blueprint ID by replacing it with the desired vehicle.
For example:

```
"vehicle_model": "vehicle.toyota.prius"
```

# Demo Video

All videos can be found here: https://www.youtube.com/playlist?list=PLT6vZE-j-Q_txkFGr4UAbPygAfNeKJL9n


# Acknowledgements
This implementation is based on code from the following repositories:

* [TransFuser](https://github.com/autonomousvision/transfuser)
* [CIL++](https://github.com/yixiao1/CILv2_multiview)

# Publications
If you have used this repository in any of your scientific work, please consider citing our work:

```bibtex
@inproceedings{ajak2024comparison,
  title={A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle},
  author={Ajak, Noorsyamimi Abdur and Ong, Wee Hong and Malik, Owais Ahmed},
  booktitle={2024 IEEE Intelligent Vehicles Symposium (IV)},
  pages={1693--1698},
  year={2024},
  organization={IEEE}
}
```
