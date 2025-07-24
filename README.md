# A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle

This repository contains source codes and demo video for the experiments in our paper "A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle".

## [Paper](https://ailab.space/wp-content/uploads/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/IV24_0299_FI.pdf) | [Poster](https://ailab.space/wp-content/uploads/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/MoPo2I4.12-Poster.pdf) | [Project Page](https://ailab.space/projects/improving-egovehicle-control-in-deep-learning-training-pipeline-for-autonomous-cars/) | [Demo Video](https://www.youtube.com/playlist?list=PLT6vZE-j-Q_txkFGr4UAbPygAfNeKJL9n)

# Contents

1. [Setup](#setup)
2. [How to Change the Vehicle](#how-to-change-the-vehicle)
3. [Running an Agent](#running-an-agent)

# Setup

We followed and adapted the codebases from the following public repositories. Each represents a distinct imitation learning pipeline architecture. For installation, training, and evaluation, you can refer to the original instructions provided by each repository, while this repo includes modifications necessary to enable changing the ego-vehicle in the experiments.

## Waypoint-based IL model
We selected [TransFuser](https://github.com/autonomousvision/transfuser) as the representative for the waypoint-based approach. TransFuser uses sensor fusion to predict future waypoints.

## Control-based IL model

We selected [CIL++](https://github.com/yixiao1/CILv2_multiview) as the representative for the control-based approach. CIL++ directly predicts control signals from the sensor inputs.

## Replacing Original Folder with Our Modified Version

To use our modified implementation for evaluation or training, please replace the original folder from the base repository with the one provided in this repository.

# How to Change the Vehicle

To evaluate the performance of the models with different ego-vehicles, follow the instructions below for each pipeline:

## TransFuser

## CIL++

# Running an Agent

To run an agent in the CARLA environment for each pipeline, follow these steps:

# TransFuser
1. Start the CARLA server

```
./transfuser/carla/CarlaUE4.sh --world-port=2000 -opengl
```

2. Run the evaluation script
```
```

# CIL++

1. Start the CARLA server

```
```

2. Run the evaluation script
```
```

# Demo Video

All videos can be found [here](https://www.youtube.com/playlist?list=PLT6vZE-j-Q_txkFGr4UAbPygAfNeKJL9n).


# Acknowledgements
This implementation is based on code from several repositories:

* [TransFuser](https://github.com/autonomousvision/transfuser)
* [CIL++](https://github.com/yixiao1/CILv2_multiview)


# Publications
If you have used this repository in any of your scientific work, please consider citing our work:

```bibtex
@inproceedings{Noorsyamimi2024IV,
  author = {Abdur Ajak, Noorsyamimi and
            Ong, Wee Hong and
            Malik, Owais Ahmed},
  title = {A Comparison of Imitation Learning Pipelines for Autonomous Driving on the Effect of Change in Ego-vehicle},
  booktitle = {IEEE Intelligent Vehicles Symposium (IV)},
  year = {2024}
}
```
