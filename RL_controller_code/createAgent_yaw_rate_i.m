clear yaw_rate_i obsInfo actInfo initOpts

obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name        = 'observations';
obsInfo.Description = 'yaw_rate_err, y_dot';

actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Ki_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;
yaw_rate_i = rlDDPGAgent(obsInfo, actInfo, initOpts);

yaw_rate_i.AgentOptions.SampleTime = 0.02;
yaw_rate_i.AgentOptions.DiscountFactor = 0.99;
yaw_rate_i.AgentOptions.MiniBatchSize = 128;
yaw_rate_i.AgentOptions.ExperienceBufferLength = 1e6;
yaw_rate_i.AgentOptions.TargetSmoothFactor = 1e-3;
yaw_rate_i.AgentOptions.NoiseOptions.Variance = 0.3;
yaw_rate_i.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Yaw rate I agent created:')
disp(yaw_rate_i)