clear yaw_rate_d obsInfo actInfo initOpts

obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name        = 'observations';
obsInfo.Description = 'yaw_rate_err, y_dot';

actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Kd_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;
yaw_rate_d = rlDDPGAgent(obsInfo, actInfo, initOpts);

yaw_rate_d.AgentOptions.SampleTime = 0.02;
yaw_rate_d.AgentOptions.DiscountFactor = 0.99;
yaw_rate_d.AgentOptions.MiniBatchSize = 128;
yaw_rate_d.AgentOptions.ExperienceBufferLength = 1e6;
yaw_rate_d.AgentOptions.TargetSmoothFactor  = 1e-3;
yaw_rate_d.AgentOptions.NoiseOptions.Variance = 0.3;
yaw_rate_d.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Yaw rate D agent created:')
disp(yaw_rate_d)