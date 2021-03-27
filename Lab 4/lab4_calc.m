%% EXP1.1; DESIGN PHASE LEAD COMPENSATOR
% AVERAGE TAU_M AND ALPHA VALUES FROM LAB 2
tau_m = (0.133 + 0.155)/2;
A = (25.877 + 30.303)/2;
% CREATE SYSTEM FROM VALUES
sysG = tf(1, [1 1/tau_m 0]);
polesG = pole(sysG); % DETERMINE POLES OF THE SYSTEM

% DESIGN REQUIREMENTS
po = 20;
settle_time = 0.5;

% CALCULATE REAL PART OF DESIRED ROOT LOCUS USING 2ND-ORDER SYS APPROXIMATION
sigma = 4 / settle_time;
% CALCULATE ZETA USING PERCENT OVERSHOOT
zeta = -log(po/100)/sqrt(pi^2 + log(po/100)^2);
phi = acos(zeta); % DETERMINE ANGLE FROM ZETA
omega = sigma * tan(phi); % CALCULATE IMAGINARY PART OF DESIRED ROOT LOCUS

poles_rlocus = [(-sigma + omega*1j) (-sigma - omega*1j)];
s0 = poles_rlocus(1); % PICK POSITIVE IMAGINARY ROOT FOR CALCULATIONS

% PLACE ZERO UNDER ROOT LOCUS
z = sigma;

% PHASE CONDITION
% DETERMINE PHASE CONTRIBUTIONS FROM POLES OF PLANT
phase0 = rad2deg(atan2(imag(s0) - imag(polesG(1)), real(s0) - real(polesG(1))));
phase1 = rad2deg(atan2(imag(s0) - imag(polesG(2)), real(s0) - real(polesG(2))));
angle_G = -phase0  - phase1;

% DETERMINE REQUIRED PHASE CONTRIBUTION FROM CONTROLLER; DETERMINE POSITION OF POLE
angle_Gc = 180 - angle_G - 360; 
angle_Gc_pole = 90 - angle_Gc;
p = (sigma - omega*tan(angle_Gc_pole));

% PLACE ZEROS AND POLES FOR CONTROLLER AT -Z AND -P
Gc_zero = -z;
Gc_pole = -p;

% MAGNITUDE CONDITION
% DETERMINE MAGNITUDE CONTRIBUTIONS FROM POLES AND ZEROS
mag_poles = norm(s0 - polesG(1)) * norm(s0 - polesG(2)) * norm(s0 - Gc_pole);
mag_zeros = omega;

kG = A/tau_m; % PLANT GAIN

% DETERMINE CONTROLLER GAIN FROM MAGNITUDE CONDITION
kc = (1/kG) * (mag_poles/mag_zeros); 

%% EXP1.2; CALCULATE VELOCITY ERROR CONSTANT
kv = (kG * kc * z) / (p/tau_m);

%% EXP1.3; COMPUTE CLOSED-LOOP TRANSFER FUNCTION T(s)
sysGc = tf([1 -Gc_zero],[1 -Gc_pole]); % SYSTEM FOR CONTROLLER
G_s = series(sysG, kG); % INTRODUCE PLANT GAIN
Gc_s = series(sysGc, kc); % INTRODUCE CONTROLLER GAIN
scaled_P_s = series(G_s, Gc_s); % GET SERIES OF PLANT AND CONTROLLER
T_s = feedback(scaled_P_s, 1); % GET TRANSFER FUNCTION
cl_poles = pole(T_s); % POLES OF TRANSFER FUNCTION
cl_zeros = zero(T_s); % ZEROS OF TRANSFER FUNCTION

%% EXP1.4; PLOT STEP RESPONSE
fig_step = figure(1);
step(T_s);
exportgraphics(fig_step, 'Report/Figures/step_response.png');

% EXP1.5; PLOT UNIT RAMP RESPONSE
fig_unit_ramp = figure(2);
t = 0:0.001:2; % UNIT RAMP
lsim(T_s, t, t);
exportgraphics(fig_unit_ramp, 'Report/Figures/unit_ramp_response.png');