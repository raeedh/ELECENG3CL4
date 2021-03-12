%% Experiment 2
tau_m = (0.133 + 0.155)/2; % average of lab 2 determined values
A = (25.877 + 30.303)/2; % average of lab 2 determined values

po = [50 55 60 65]; % percent overshoot specifications
kp = ((-pi./log(po./100)).^2 + 1) ./ (4 * A * tau_m)

%% Experiment 3
po = 10;
zeta = -log(po/100)/sqrt(pi^2 + log(po/100)^2);
kp = [5 6 7];
kv = (zeta*2*sqrt(kp*A*tau_m)-1)/A