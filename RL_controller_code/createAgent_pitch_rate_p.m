clear pitch_rate_p obsInfo actInfo initOpts


obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name        = 'observations';
obsInfo.Description = 'pitch_rate_err, p_dot';


actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Kp_action';


initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;
pitch_rate_p = rlDDPGAgent(obsInfo, actInfo, initOpts);


pitch_rate_p.AgentOptions.SampleTime  = 0.02;
pitch_rate_p.AgentOptions.DiscountFactor = 0.99;
pitch_rate_p.AgentOptions.MiniBatchSize  = 128;
pitch_rate_p.AgentOptions.ExperienceBufferLength = 1e6;
pitch_rate_p.AgentOptions.TargetSmoothFactor = 1e-3;
pitch_rate_p.AgentOptions.NoiseOptions.Variance  = 0.3;
pitch_rate_p.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Pitch rate P agent created:')
disp(pitch_rate_p)