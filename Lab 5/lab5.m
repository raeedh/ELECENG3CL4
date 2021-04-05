clear variables; clear global; close all;
%% EXP1.1; DESIGN PHASE LEAD COMPENSATOR
% AVERAGE TAU_M AND ALPHA VALUES FROM LAB 2
tau_m = (0.133 + 0.155)/2;
A = (25.877 + 30.303)/2;
% CREATE SYSTEM FROM VALUES
sysG = tf(1, [1,1/tau_m,0]);
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

%% REDUCE STEADY STATE ERROR DUE TO STEP DISTRUBANCE BY FACTOR OF 10
zlag = 0.2;
plag = 0.02;
% CHECK ANGLE DIFFERENCE
phase0_lag = rad2deg(atan2(imag(s0) - imag(-zlag), real(s0) - real(-zlag)));
phase1_lag = rad2deg(atan2(imag(s0) - imag(-plag), real(s0) - real(-plag)));
angle_lag = abs(phase0_lag - phase1_lag)

% %% EXP1.3; COMPUTE CLOSED-LOOP TRANSFER FUNCTION T(s)
% sysGc = tf([1,Gc_zero],[1,Gc_pole]); % SYSTEM FOR CONTROLLER
% 
% G = series(sysG, kG); % INTRODUCE PLANT GAIN
% Gc_lead = series(sysGc, kc); % INTRODUCE CONTROLLER GAIN

G = tf(A/tau_m,[1,1/tau_m,0]);
Gc_lead=tf(kc*[1,z],[1,p]);

zlag = 0.2;
plag = zlag/10;

%Construct the transfer function model of the lead-lag compensator
lag_system=tf([1,zlag],[1,plag]);
Gc_leadlag=series(lag_system,Gc_lead);

%Construct the open loop transfer functions
L_lead=series(Gc_lead,G);
L_leadlag=series(Gc_leadlag,G);

%Draw the root locus plots
figure(1)
rlocus(L_lead)
hold on
rlocus(L_leadlag)

%Construct closed loop transfer functions
T_lead=feedback(L_lead,1);
T_leadlag=feedback(L_leadlag,1);

%Determine closed-loop pole positions
cl_poles_lead = pole(T_lead)
cl_poles_leadlag = pole(T_leadlag)

%Plot the closed loop pole positions. Lead with square, lead-lag with
%triangle
plot(real(cl_poles_lead),imag(cl_poles_lead),'s');
plot(real(cl_poles_leadlag),imag(cl_poles_leadlag),'^')

%Calculate the step responses
figure(2)
step(T_lead)
hold on
step(T_leadlag)

%Calculate the ramp responses
figure(3)
[maxpole,index_maxpole]=max(real(cl_poles_leadlag));
Tmax=4/abs(maxpole);
tvec=0:0.01:Tmax;
input_vec=tvec;
lsim(T_lead,input_vec,tvec)
hold on
lsim(T_leadlag,input_vec,tvec)

%Draw the Bode diagrams
figure
bode(L_lead)
hold on
bode(L_leadlag)
grid

%Construct the closed-loop transfer function from disturbances to output
disturbance_TF_lead = feedback(G,Gc_lead);
disturbance_TF_leadlag=feedback(G,Gc_leadlag);

%Calculate disturbance transfer functions
figure
step(disturbance_TF_lead,50);
hold on
step(disturbance_TF_leadlag,50);
grid