clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_rate_p.mat',   'kp_yaw_rate');
load('tuned_pitch_rate_p.mat', 'kp_pitch_rate');
assignin('base', 'kp_yaw_rate',   kp_yaw_rate);
assignin('base', 'kp_pitch_rate', kp_pitch_rate);
mdl = 'hoverSim_pid';
open_system(mdl);
kp_var = optimizableVariable('kp_roll_rate', [20, 30], 'Type', 'real');
results = bayesopt(@objectiveRollRateP, kp_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Kp = results.XAtMinObjective.kp_roll_rate;
fprintf('\nBeste kp_roll_rate: %.4f\n', best_Kp);
kp_roll_rate = best_Kp;
save('tuned_roll_rate_p.mat', 'kp_roll_rate');
disp('Lagret til tuned_roll_rate_p.mat');