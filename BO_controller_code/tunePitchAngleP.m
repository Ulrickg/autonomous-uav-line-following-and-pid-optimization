clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_angle_p.mat', 'kp_yaw_angle');
assignin('base', 'kp_yaw_angle', kp_yaw_angle);
mdl = 'hoverSim_pid';
open_system(mdl);
kp_var = optimizableVariable('kp_pitch_angle', [1.9, 20], 'Type', 'real');
results = bayesopt(@objectivePitchAngleP, kp_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Kp = results.XAtMinObjective.kp_pitch_angle;
fprintf('\nBeste kp_pitch_angle: %.4f\n', best_Kp);
kp_pitch_angle = best_Kp;
save('tuned_pitch_angle_p.mat', 'kp_pitch_angle');
disp('Lagret til tuned_pitch_angle_p.mat');