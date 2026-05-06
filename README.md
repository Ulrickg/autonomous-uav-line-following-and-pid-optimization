# Autonomous UAV Line-Following and PID Optimization

This repository contains the source code, Simulink models, and supporting files used in the bachelor thesis:

**Vision-Based Autonomous Line-Following for UAVs and Machine Learning Approaches to PID Controller Tuning**

## Repository Structure

- `BO_controller_code/`  
  Code related to Bayesian optimization-based PID tuning.

- `RL_controller_code/`  
  Code related to reinforcement learning-based PID tuning.

- `manually_tuned_controller_code/`  
  Code related to manually tuned PID controllers.

- `parrotMinidroneCompetition_ERF2026.../`  
  Simulink project and files related to the Parrot Mambo minidrone line-following implementation.

## Running the 3-DoF Hover Controller Simulations

To run the controller codes in `BO_controller_code`, `RL_controller_code`, and `manually_tuned_controller_code`, it is necessary to run `setupHover.m` and open `hoverSim_pid.slx`.

These files contain the required system parameters and the simulation environment used by the controllers.

## Running the Parrot Mambo Minidrone Project

For the Parrot Mambo minidrone line-following implementation, open the Simulink project `MinidroneCompetition.prj`.

This project contains the required setup for the Parrot Mambo minidrone simulation and vision-based path-following system.

## Notes

The code and models are provided as supporting material for the bachelor thesis and are intended to document the implementation used for the simulations and experiments.
