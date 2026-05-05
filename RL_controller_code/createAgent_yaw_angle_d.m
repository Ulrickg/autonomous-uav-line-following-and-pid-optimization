clear yaw_angle_d obsInfo actInfo initOpts

obsInfo = rlNumericSpec([2 1], ...
'LowerLimit', [-inf; -inf], ...
'UpperLimit', [ inf;  inf]);
obsInfo.Name = 'observations';
obsInfo.Description = 'yaw_err, yaw';

actInfo = rlNumericSpec([1 1], ...
'LowerLimit', -1, ...
'UpperLimit',  1);
actInfo.Name = 'Kd_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;
yaw_angle_d = rlDDPGAgent(obsInfo, actInfo, initOpts);

yaw_angle_d.AgentOptions.SampleTime                     = 0.02;
yaw_angle_d.AgentOptions.DiscountFactor                 = 0.99;
yaw_angle_d.AgentOptions.MiniBatchSize                  = 128;
yaw_angle_d.AgentOptions.ExperienceBufferLength         = 1e6;
yaw_angle_d.AgentOptions.TargetSmoothFactor             = 1e-3;
yaw_angle_d.AgentOptions.NoiseOptions.Variance          = 0.3;
yaw_angle_d.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Agent created:')
disp(yaw_angle_d)