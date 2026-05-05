clear; clc; close all;
rng(0)

run('setupHover.m');

mdl = 'hoverSim_pid_RL';
open_system(mdl);

obsInfo = rlNumericSpec([2 1], ...
'LowerLimit', [-inf; -inf], ...
'UpperLimit', [ inf;  inf]);
obsInfo.Name = 'observations';
obsInfo.Description = 'yaw_err, yaw';

actInfo = rlNumericSpec([1 1], ...
'LowerLimit', -1, ...
'UpperLimit',  1);
actInfo.Name = 'Kd_action';

run('createAgent_yaw_angle_d.m');

agentBlk = 'hoverSim_pid_RL/Angle_PID/yaw_angle_pid/RL_yaw_angle_d';
env = rlSimulinkEnv(mdl, agentBlk, obsInfo, actInfo);

trainOpts = rlTrainingOptions( ...
'MaxEpisodes',                300,  ...
'MaxStepsPerEpisode',         1500, ...
'ScoreAveragingWindowLength', 20,   ...
'Verbose',                    true, ...
'Plots',                      'training-progress', ...
'StopTrainingCriteria',       'AverageReward', ...
'StopTrainingValue',          1200);

% ===== TRAIN =====
trainingStats = train(yaw_angle_d, env, trainOpts);

% ===== SAVE =====
save('trained_yaw_angle_d.mat', 'yaw_angle_d', 'trainingStats');