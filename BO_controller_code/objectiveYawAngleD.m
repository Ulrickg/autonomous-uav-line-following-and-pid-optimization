function cost = objectiveYawAngleD(x)

Kd = x.kd_yaw_angle;
assignin('base', 'kd_yaw_angle', Kd);

simOut = sim('hoverSim_pid');

yaw = simOut.logsout.getElement('yaw').Values;
t = yaw.Time;
y = yaw.Data;

ref = 0.5;

idx_rise = find(y >= 0.9 * ref, 1, 'first');
if isempty(idx_rise)
    rise_time = t(end);
else
    rise_time = t(idx_rise);
end

overshoot = max(0, (max(y) - ref) / ref * 100);

idx_ss = find(t >= t(end) - 10, 1, 'first');
ss_error = abs(mean(y(idx_ss:end)) - ref);

w_rise = 1;
w_overshoot = 2;
w_ss= 5;

cost = w_rise * rise_time + w_overshoot * overshoot + w_ss * ss_error;

fprintf('Kd=%.4f | stigetid=%.2fs | oversving=%.1f%% | ss_feil=%.4f | kostnad=%.3f\n', ...
    Kd, rise_time, overshoot, ss_error, cost);
end