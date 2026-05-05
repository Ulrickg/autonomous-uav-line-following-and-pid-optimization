% createAgent_yaw_rate_p.m
clear yaw_rate_p obsInfo actInfo initOpts

% observation
obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name = 'observations';
obsInfo.Description = 'yaw_rate_err, y_dot';

% action
actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Kp_action';

%agent init.
initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;

yaw_rate_p = rlDDPGAgent(obsInfo, actInfo, initOpts);

%agent ouputs
yaw_rate_p.AgentOptions.SampleTime = 0.02;
yaw_rate_p.AgentOptions.DiscountFactor = 0.99;
yaw_rate_p.AgentOptions.MiniBatchSize = 128;
yaw_rate_p.AgentOptions.ExperienceBufferLength = 1e6;
yaw_rate_p.AgentOptions.TargetSmoothFactor = 1e-3;
yaw_rate_p.AgentOptions.NoiseOptions.Variance = 0.3;
yaw_rate_p.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Agent created:')
disp(yaw_rate_p)