clear pitch_angle_d obsInfo actInfo initOpts

obsInfo = rlNumericSpec([1 1],'LowerLimit',-inf,'UpperLimit',inf);
obsInfo.Name = 'observation';

actInfo = rlNumericSpec([1 1],'LowerLimit',-1,'UpperLimit',1);
actInfo.Name = 'Kd_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 32;

pitch_angle_d = rlDDPGAgent(obsInfo,actInfo,initOpts);

pitch_angle_d.AgentOptions.SampleTime = 0.02;
pitch_angle_d.AgentOptions.DiscountFactor = 0.99;
pitch_angle_d.AgentOptions.MiniBatchSize = 64;
pitch_angle_d.AgentOptions.ExperienceBufferLength = 1e5;
pitch_angle_d.AgentOptions.TargetSmoothFactor = 1e-3;
pitch_angle_d.AgentOptions.NoiseOptions.Variance = 0.2;
pitch_angle_d.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-4;