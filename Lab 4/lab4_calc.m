% EXP1.1
tau_m = (0.133 + 0.155)/2;
A = (25.877 + 30.303)/2;
sysG = tf(1, [1 1/tau_m 0]);
polesG = pole(sysG);

po = 20;
settle_time = 0.5;

sigma = 4 / settle_time;
zeta = -log(po/100)/sqrt(pi^2 + log(po/100)^2);
phi = acos(zeta);
omega = sigma * tan(phi);

poles_rlocus = [(-sigma + omega*1j) (-sigma - omega*1j)];
s0 = poles_rlocus(1);

z = sigma;

% phase condition
phase0 = rad2deg(atan2(imag(s0) - imag(polesG(1)), real(s0) - real(polesG(1))));
phase1 = rad2deg(atan2(imag(s0) - imag(polesG(2)), real(s0) - real(polesG(2))));
angle_G = -phase0  - phase1;

angle_Gc = 180 - angle_G - 360;

angle_Gc_pole = 90 - angle_Gc;
p = (sigma - omega*tan(angle_Gc_pole));

Gc_zero = -z;
Gc_pole = -p;

% magnitude condition
mag_poles = norm(s0 - polesG(1)) * norm(s0 - polesG(2)) * norm(s0 - Gc_pole);
mag_zeros = omega;

kG = A/tau_m;

kc = (1/kG) * (mag_poles/mag_zeros);

% EXP1.2
kv = (kG * kc * z) / (p/tau_m);

% EXP1.3
sysGc = tf([1 -Gc_zero],[1 -Gc_pole]);
G_s = series(sysG, kG);
Gc_s = series(sysGc, kc);

scaled_P_s = series(G_s, Gc_s);
% rlocus(scaled_P_s);
T_s = feedback(scaled_P_s, 1);
cl_poles = pole(T_s);
cl_zeros = zero(T_s);

% EXP1.4
% step(T_s)

% EXP1.5
t = 0:0.001:2;
lsim(T_s, t, t)