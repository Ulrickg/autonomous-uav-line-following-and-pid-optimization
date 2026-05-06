clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_rate_p.mat', 'kp_yaw_rate');
assignin('base', 'kp_yaw_rate', kp_yaw_rate);
mdl = 'hoverSim_pid';
open_system(mdl);
kp_var = optimizableVariable('kp_pitch_rate', [28, 35], 'Type', 'real');
results = bayesopt(@objectivePitchRateP, kp_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Kp = results.XAtMinObjective.kp_pitch_rate;
fprintf('\nBeste kp_pitch_rate: %.4f\n', best_Kp);
kp_pitch_rate = best_Kp;
save('tuned_pitch_rate_p.mat', 'kp_pitch_rate');
disp('Lagret til tuned_pitch_rate_p.mat');