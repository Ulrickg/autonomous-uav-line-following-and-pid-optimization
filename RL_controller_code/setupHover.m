% 3 DOF HOVER Control Lab: 
% 
% SETUP_LAB_HOVER sets the model parameters.
%
% Copyright (C) 2010 Quanser Consulting Inc.
% Quanser Consulting Inc.
%

%% Amplifier Configuration
% Amplifier gain used for yaw and pitch axes.
K_AMP = 3;
% Amplifier Maximum Output Voltage (V)
VMAX_AMP = 24;
% Digital-to-Analog Maximum Voltage (V): set to 10 for Q4/Q8 cards
VMAX_DAC = 10;
%
%% Filter and Rate Limiter Settings
% Specifications of a second-order low-pass filter
wcf = 2 * pi * 20; % filter cutting frequency
zetaf = 0.6;        % filter damping ratio
%
% Maximum Rate of Desired Position (rad/s)
CMD_RATE_LIMIT = 60 * pi/180; % 60 deg/s converted to rad/s

%% Set the model parameters of the 3DOF HOVER.
% These parameters are used for model representation and controller design.
% Gravitational Constant (m/s^2)
g = 9.81;
% Motor Armature Resistance (Ohm)
Rm = 0.83;
% Motor Current-Torque Constant (N.m/A)
Kt_m = 0.0182;
% Motor Rotor Moment of Inertia (kg.m^2)
Jm = 1.91e-6;
% Moving Mass of the Hover system (kg)
m_hover = 2.85;
% Mass of each Propeller Section = motor + shield + propeller + body (kg)
m_prop = m_hover / 4;
% Distance between Pivot to each Motor (m)
L = 7.75*0.0254;
% Propeller Force-Thrust Constant found Experimentally (N/V)
Kf = 0.1188;
% Propeller Torque-Thrust Constant found Experimentally (N-m/V)
Kt = 0.0036;
% note: front/back motor are counter-clockwise (negative torque) and 
% left/right motor are clockwise (positive torque).
% 
% Equivalent Moment of Inertia of each Propeller Section (kg.m^2)
Jeq_prop = Jm + m_prop*L^2;
% Equivalent Moment of Inertia about each Axis (kg.m^2)
Jp = 2*Jeq_prop;
Jy = 4*Jeq_prop;
Jr = 2*Jeq_prop;
%
% Pitch and Yaw Axis Encoder Resolution (rad/count)
K_EC_Y = -2 * pi / ( 8 * 1024 );
K_EC_P = 2 * pi / ( 8 * 1024 );
K_EC_R = 2 * pi / ( 8 * 1024 );
% Bias voltage applied to motors (V)
V_bias = 2.0;

%Geometry files:
geomFolder = fullfile(pwd, 'geometry');
addpath(geomFolder);

%% State-space compact representation:
A = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0];


B = [0     0     0     0;
     0     0     0     0;
     0     0     0     0;
     0.0326 -0.0326 0.0326 -0.0326;
     0.423  0      -0.423  0;
     0      0.423   0     -0.423];



% C matrix
C = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0];

% D matrix
D = zeros(3,4);

% K matrix

K = [ 1  1  0;
     -1  0  1;
      1 -1  0;
     -1  0 -1 ];


% Lagre verdier
% save('trained_yaw_rate_p.mat','yaw_rate_p')

% Lagrede verdier for PID regulator

if exist('trained_yaw_rate_p.mat','file')
    load('trained_yaw_rate_p.mat')
end


if exist('trained_yaw_rate_i.mat','file')
    load('trained_yaw_rate_i.mat')
end


if exist('trained_yaw_rate_d.mat','file')
    load('trained_yaw_rate_d.mat')
end

if exist('trained_pitch_rate_p.mat','file')
    load('trained_pitch_rate_p.mat')
end

if exist('trained_pitch_rate_i.mat','file')
    load('trained_pitch_rate_i.mat')
end

if exist('trained_pitch_rate_d.mat','file')
    load('trained_pitch_rate_d.mat')
end

if exist('trained_roll_rate_p.mat','file')
    load('trained_roll_rate_p.mat')
end

if exist('trained_roll_rate_i.mat','file')
    load('trained_roll_rate_i.mat')
end

if exist('trained_roll_rate_d.mat','file')
    load('trained_roll_rate_d.mat')
end


if exist('trained_yaw_angle_p.mat','file')
    load('trained_yaw_angle_p.mat')
end

if exist('trained_yaw_angle_i.mat','file')
    load('trained_yaw_angle_i.mat')
end

if exist('trained_yaw_angle_d.mat','file')
    load('trained_yaw_angle_d.mat')
end

if exist('trained_pitch_angle_p.mat','file')
    load('trained_pitch_angle_p.mat')
end

if exist('trained_pitch_angle_i.mat','file')
    load('trained_pitch_angle_i.mat')
end

if exist('trained_pitch_angle_d.mat','file')
    load('trained_pitch_angle_d.mat')
end


if exist('trained_pitch_angle_d.mat','file')
    load('trained_pitch_angle_d.mat')
end

if exist('trained_roll_angle_p.mat','file')
    load('trained_roll_angle_p.mat')
end

if exist('trained_roll_angle_i.mat','file')
    load('trained_roll_angle_i.mat')
end

if exist('trained_roll_angle_d.mat','file')
    load('trained_roll_angle_d.mat')
end
