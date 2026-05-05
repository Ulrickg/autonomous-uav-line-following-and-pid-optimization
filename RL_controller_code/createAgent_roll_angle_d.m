clear roll_angle_d obsInfo actInfo initOpts

obsInfo = rlNumericSpec([1 1],'LowerLimit',-inf,'UpperLimit',inf);
obsInfo.Name = 'observation';

actInfo = rlNumericSpec([1 1],'LowerLimit',-1,'UpperLimit',1);
actInfo.Name = 'Kd_action';

initOpts = rlAgentInitializationOptions;
initOpts.NumHiddenUnit = 32;

roll_angle_d = rlDDPGAgent(obsInfo,actInfo,initOpts);

roll_angle_d.AgentOptions.SampleTime = 0.02;
roll_angle_d.AgentOptions.DiscountFactor = 0.99;
roll_angle_d.AgentOptions.MiniBatchSize = 64;
roll_angle_d.AgentOptions.ExperienceBufferLength = 1e5;
roll_angle_d.AgentOptions.TargetSmoothFactor = 1e-3;
roll_angle_d.AgentOptions.NoiseOptions.Variance = 0.2;
roll_angle_d.AgentOptions.NoiseOptions.VarianceDecayRate = 1e-4;