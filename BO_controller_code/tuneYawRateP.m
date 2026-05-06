% tuneYawRateP.m
clear; clc; close all;

run('setupHover.m');

mdl = 'hoverSim_pid';
open_system(mdl);


kp_var = optimizableVariable('kp_yaw_rate', [21.5, 25], 'Type', 'real');


results = bayesopt(@objectiveYawRateP, kp_var, ...
    'MaxObjectiveEvaluations',  30, ...
    'IsObjectiveDeterministic', true, ...
    'AcquisitionFunctionName',  'expected-improvement-plus', ...
    'Verbose',                   1, ...
    'PlotFcn', {@plotObjectiveModel, @plotMinObjective});


best_Kp = results.XAtMinObjective.kp_yaw_rate;
fprintf('\nBeste kp_yaw_rate: %.4f\n', best_Kp);

% save result
kp_yaw_rate = best_Kp;
save('tuned_yaw_rate_p.mat', 'kp_yaw_rate');
disp('Lagret til tuned_yaw_rate_p.mat');