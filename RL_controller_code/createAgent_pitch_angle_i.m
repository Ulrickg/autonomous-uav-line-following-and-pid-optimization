clear pitch_angle_i obsInfo actInfo initOpts

obsInfo = rlNumericSpec([2 1], ...
    'LowerLimit', [-inf; -inf], ...
    'UpperLimit', [ inf;  inf]);
obsInfo.Name        = 'observations';
obsInfo.Description = 'pitch_err, pitch';

actInfo = rlNumericSpec([1 1], ...
    'LowerLimit', -1, ...
    'UpperLimit',  1);
actInfo.Name = 'Ki_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 64;

pitch_angle_i = rlDDPGAgent(obsInfo, actInfo, initOpts);

pitch_angle_i.AgentOptions.SampleTime                     = 0.02;
pitch_angle_i.AgentOptions.DiscountFactor                 = 0.99;
pitch_angle_i.AgentOptions.MiniBatchSize                  = 128;
pitch_angle_i.AgentOptions.ExperienceBufferLength         = 1e6;
pitch_angle_i.AgentOptions.TargetSmoothFactor             = 1e-3;
pitch_angle_i.AgentOptions.NoiseOptions.Variance          = 0.3;
pitch_angle_i.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-5;

disp('Pitch angle I agent created:')
disp(pitch_angle_i)