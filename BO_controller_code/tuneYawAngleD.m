clear; clc; close all;
run('setupHover.m');
load('tuned_yaw_angle_p.mat',   'kp_yaw_angle');
load('tuned_yaw_angle_i.mat',   'ki_yaw_angle');
load('tuned_pitch_angle_p.mat', 'kp_pitch_angle');
load('tuned_pitch_angle_i.mat', 'ki_pitch_angle');
load('tuned_roll_angle_p.mat',  'kp_roll_angle');
load('tuned_roll_angle_i.mat',  'ki_roll_angle');
assignin('base', 'kp_yaw_angle',   kp_yaw_angle);
assignin('base', 'ki_yaw_angle',   ki_yaw_angle);
assignin('base', 'kp_pitch_angle', kp_pitch_angle);
assignin('base', 'ki_pitch_angle', ki_pitch_angle);
assignin('base', 'kp_roll_angle',  kp_roll_angle);
assignin('base', 'ki_roll_angle',  ki_roll_angle);
mdl = 'hoverSim_pid';
open_system(mdl);
kd_var = optimizableVariable('kd_yaw_angle', [0, 5], 'Type', 'real');
results = bayesopt(@objectiveYawAngleD, kd_var, ...
'MaxObjectiveEvaluations',  30, ...
'IsObjectiveDeterministic', true, ...
'AcquisitionFunctionName',  'expected-improvement-plus', ...
'Verbose',                   1, ...
'PlotFcn', {@plotObjectiveModel, @plotMinObjective});
best_Kd = results.XAtMinObjective.kd_yaw_angle;
fprintf('\nBeste kd_yaw_angle: %.4f\n', best_Kd);
kd_yaw_angle = best_Kd;
save('tuned_yaw_angle_d.mat', 'kd_yaw_angle');
disp('Lagret til tuned_yaw_angle_d.mat');