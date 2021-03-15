close all;
clear;

tau_m = (0.133 + 0.155)/2; % average of lab 2 determined values
A = (25.877 + 30.303)/2; % average of lab 2 determined values

%% EXPERIMENT 1 & 2 PLOTS
G = tf([A], [tau_m 1 0]);
kp = [0.5 1 2 3 4 5];
opt = pzoptions('cstprefs');
opt.Grid = 'on'; % comment this out if you don't want the zeta and w_n grid
opt.GridColor = 'black';
opt.Xlim = [-4 0];
labels = {};
for i = kp
    % Poles
    C1 = pid(i);
    CL1 = feedback(G * C1, 1);
    h = pzplot(CL1, opt);
    labels(end+1) = {"$k_p$ = " + num2str(i)};
    hold on;
end
legend(labels,'interpreter','latex');
hold off;

% EXPERIMENT 2 PLOTS
figure()
kp = [1.3314 1.7685 2.3395 3.3489];
opt = pzoptions('cstprefs');
opt.Grid = 'on'; % comment this out if you don't want the zeta and w_n grid
opt.GridColor = 'black';
opt.Xlim = [-4 0];
labels = {};
for i = kp
    % More Poles
    C1 = pid(i);
    CL1 = feedback(G * C1, 1);
    h = pzplot(CL1, opt);
    labels(end+1) = {"$k_p$ = " + num2str(i)};
    hold on;
end
legend(labels,'interpreter','latex');
hold off;

%% EXPERIMENT 3 PLOTS
figure()
kp = [5 6 7];
kv = [0.1537 0.1718 0.1884];
opt = pzoptions('cstprefs');
opt.Grid = 'on'; % comment this out if you don't want the zeta and w_n grid
opt.GridColor = 'black';
labels = {};
for i = kp
    % Even More Poles (Kv = 0)
    T = tf([(i * A / tau_m)], [1.0 (1.0 / tau_m) (i * A / tau_m)]);
    h = pzplot(T, opt);
    labels(end+1) = {"$k_p$ = " + num2str(i) + ", $k_v$ = 0"};
    hold on;
end

for i = 1:3
    % Even More Poles
    T = tf([(kp(i) * A / tau_m)], [1.0 ((1.0 + kv(i) * A) / tau_m) (kp(i) * A / tau_m)]);
    h = pzplot(T, opt);
    labels(end+1) = {"$k_p$ = " + num2str(kp(i)) + ", $k_v$ = " + num2str(kv(i))};
    hold on;
end
legend(labels,'interpreter','latex');
hold off;
