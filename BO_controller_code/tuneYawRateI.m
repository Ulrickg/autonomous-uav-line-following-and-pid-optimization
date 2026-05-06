clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_rate_p.mat',   'kp_yaw_rate');
load('tuned_pitch_rate_p.mat', 'kp_pitch_rate');
load('tuned_roll_rate_p.mat',  'kp_roll_rate');
assignin('base', 'kp_yaw_rate',   kp_yaw_rate);
assignin('base', 'kp_pitch_rate', kp_pitch_rate);
assignin('base', 'kp_roll_rate',  kp_roll_rate);
mdl = 'hoverSim_pid';
open_system(mdl);
ki_var = optimizableVariable('ki_yaw_rate', [4, 15], 'Type', 'real');
results = bayesopt(@objectiveYawRateI, ki_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Ki = results.XAtMinObjective.ki_yaw_rate;
fprintf('\nBeste ki_yaw_rate: %.4f\n', best_Ki);
ki_yaw_rate = best_Ki;
save('tuned_yaw_rate_i.mat', 'ki_yaw_rate');
disp('Lagret til tuned_yaw_rate_i.mat');