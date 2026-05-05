clear roll_angle_i obsInfo actInfo initOpts

obsInfo = rlNumericSpec([1 1],'LowerLimit',-inf,'UpperLimit',inf);
obsInfo.Name = 'observation';

actInfo = rlNumericSpec([1 1],'LowerLimit',-1,'UpperLimit',1);
actInfo.Name = 'Ki_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 32;

roll_angle_i = rlDDPGAgent(obsInfo,actInfo,initOpts);

roll_angle_i.AgentOptions.SampleTime = 0.02;
roll_angle_i.AgentOptions.DiscountFactor = 0.99;
roll_angle_i.AgentOptions.MiniBatchSize = 64;
roll_angle_i.AgentOptions.ExperienceBufferLength = 1e5;
roll_angle_i.AgentOptions.TargetSmoothFactor = 1e-3;
roll_angle_i.AgentOptions.NoiseOptions.Variance = 0.2;
roll_angle_i.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-4;