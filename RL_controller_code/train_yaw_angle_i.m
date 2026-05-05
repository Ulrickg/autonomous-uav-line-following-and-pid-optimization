clear; clc; close all;
run('setupHover.m');
mdl = 'hoverSim_pid_RL';
open_system(mdl);
run('createAgent_yaw_angle_i.m');

obsInfo = rlNumericSpec([1 1],'LowerLimit',-inf,'UpperLimit',inf);
obsInfo.Name = 'observation';

actInfo = rlNumericSpec([1 1],'LowerLimit',-1,'UpperLimit',1);
actInfo.Name = 'Ki_action';

agentBlk = 'hoverSim_pid_RL/Angle PID/yaw_angle_pid/RL_yaw_angle_i';
env = rlSimulinkEnv(mdl,agentBlk,obsInfo,actInfo);

trainOpts = rlTrainingOptions( ...
    'MaxEpisodes',300, ...
    'MaxStepsPerEpisode',1500, ...
    'ScoreAveragingWindowLength',20, ...
    'StopTrainingCriteria','EpisodeCount', ...
    'StopTrainingValue',300, ...
    'Verbose',true, ...
    'Plots','training-progress');

trainingStats = train(yaw_angle_i,env,trainOpts);
save('trained_yaw_angle_i.mat','yaw_angle_i','trainingStats');