function cost = objectivePitchAngleD(x)
Kd = x.kd_pitch_angle;
assignin('base', 'kd_pitch_angle', Kd);
simOut = sim('hoverSim_pid');
pitch = simOut.logsout.getElement('pitch').Values;
t  = pitch.Time;
y  = pitch.Data;
ref = 0.5;
idx_rise = find(y >= 0.9 * ref, 1, 'first');
if isempty(idx_rise)
 rise_time = 10;
else
 rise_time = t(idx_rise);
end
overshoot = max(0, (max(y) - ref) / ref * 100);
t(1)=0;
threshold = 0.02 * ref;
settled = find(abs(y - ref) > threshold, 1, 'last');
if isempty(settled)
 settling_time = t(1);
else
 settling_time = t(settled);
end
w_rise   = 1;
w_overshoot = 2;
w_settling  = 5;
cost = w_rise * rise_time + w_overshoot * overshoot + w_settling * settling_time;
fprintf('Kd=%.4f | Risetime=%.2fs | Overshoot=%.1f%% | Settling=%.2fs | Cost=%.3f\n', ...
 Kd, rise_time, overshoot, settling_time, cost);
end