clear roll_rate_i obsInfo actInfo initOpts

obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name        = 'observations';
obsInfo.Description = 'roll_rate_err, r_dot';

actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Ki_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;
roll_rate_i = rlDDPGAgent(obsInfo, actInfo, initOpts);

roll_rate_i.AgentOptions.SampleTime                     = 0.02;
roll_rate_i.AgentOptions.DiscountFactor                 = 0.99;
roll_rate_i.AgentOptions.MiniBatchSize                  = 128;
roll_rate_i.AgentOptions.ExperienceBufferLength         = 1e6;
roll_rate_i.AgentOptions.TargetSmoothFactor             = 1e-3;
roll_rate_i.AgentOptions.NoiseOptions.Variance          = 0.3;
roll_rate_i.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Roll rate I agent created:')
disp(roll_rate_i)