%% Experiment 1

po = 100*(69.43/45)-100;
tp = 0.162;

zeta1 = -log(po/100) / sqrt(pi^2 + (log(po/100))^2);
omegan1 = pi / (tp*sqrt(1-zeta1^2));

%% Experiment 2

%Mp = deg2rad(139.9);
Mp = 139.9/45;
omegap = 3.06*2*pi;

zeta2 = sqrt((-4*Mp^2 + sqrt(16*Mp^4 - 16*Mp^2))/(-8*Mp^2));
omegan2 = omegap / sqrt(1 - 2*zeta2^2);

%% Motor parameters

A1 = (omegan1/(2*zeta1))/2;
tau_m1 = 1/(2*omegan1*zeta1);

A2 = (omegan2/(2*zeta2))/2;
tau_m2 = 1/(2*omegan2*zeta2);