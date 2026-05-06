clear; clc; close all;
run('setupHover.m');

mdl = 'hoverSim_pid';
open_system(mdl);
ki_var = optimizableVariable('ki_pitch_rate', [0, 10], 'Type', 'real');
results = bayesopt(@objectivePitchRateI, ki_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Ki = results.XAtMinObjective.ki_pitch_rate;
fprintf('\nBeste ki_pitch_rate: %.4f\n', best_Ki);
ki_pitch_rate = best_Ki;
save('tuned_pitch_rate_i.mat', 'ki_pitch_rate');
disp('Lagret til tuned_pitch_rate_i.mat');