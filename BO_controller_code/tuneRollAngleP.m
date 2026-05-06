clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_angle_p.mat',   'kp_yaw_angle');
load('tuned_pitch_angle_p.mat', 'kp_pitch_angle');
assignin('base', 'kp_yaw_angle',   kp_yaw_angle);
assignin('base', 'kp_pitch_angle', kp_pitch_angle);
mdl = 'hoverSim_pid';
open_system(mdl);
kp_var = optimizableVariable('kp_roll_angle', [0.1, 20], 'Type', 'real');
results = bayesopt(@objectiveRollAngleP, kp_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Kp = results.XAtMinObjective.kp_roll_angle;
fprintf('\nBeste kp_roll_angle: %.4f\n', best_Kp);
kp_roll_angle = best_Kp;
save('tuned_roll_angle_p.mat', 'kp_roll_angle');
disp('Lagret til tuned_roll_angle_p.mat');