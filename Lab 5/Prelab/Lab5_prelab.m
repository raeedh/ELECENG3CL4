clear variables; clear global; close all;

%Prelab Plant
G=tf(4.7,[1,3.2,0]);

%Enter the lead controller you designed in the prelab for Lab 4
%For reference, I have included here the lead controller that I designed.
%However, you should enter the one that you designed.
Gc_lead=tf(62.1*[1,6],[1,15.51]);

%Select a position for the zero of the lag compensator and then calculate
%the desired position of the pole
%These are suggested designs. Please feel free to adjust them as you see
%fit
zlag=0.2;
plag=zlag/5;

%Construct the transfer function model of the lead-lag compensator
lag_system=tf([1,zlag],[1,plag]);
Gc_leadlag=series(lag_system,Gc_lead);

%Construct the open loop transfer functions
L_lead=series(Gc_lead,G);
L_leadlag=series(Gc_leadlag,G);

%Draw the root locus plots
rlocus(L_lead)
hold on
rlocus(L_leadlag)

%Construct closed loop transfer functions
T_lead=feedback(L_lead,1);
T_leadlag=feedback(L_leadlag,1);

%Determine closed-loop pole positions
cl_poles_lead=pole(T_lead)
cl_poles_leadlag=pole(T_leadlag)

phase0 = rad2deg(atan2(imag(cl_poles_leadlag(1)) - 0, real(cl_poles_leadlag(1)) - zlag));
phase1 = rad2deg(atan2(imag(cl_poles_leadlag(1)) - 0, real(cl_poles_leadlag(1)) - plag));
phase_delta = phase0 - phase1

%Plot the closed loop pole positions. Lead with square, lead-lag with
%triangle
% plot(real(cl_poles_lead),imag(cl_poles_lead),'s');
% plot(real(cl_poles_leadlag),imag(cl_poles_leadlag),'^')
% 
% %Calculate the step responses
% figure
% step(T_lead)
% hold on
% step(T_leadlag)
% 
% %Calculate the ramp responses
% figure
% [maxpole,index_maxpole]=max(real(cl_poles_leadlag));
% Tmax=4/abs(maxpole);
% tvec=0:0.01:Tmax;
% input_vec=tvec;
% lsim(T_lead,input_vec,tvec)
% hold on
% lsim(T_leadlag,input_vec,tvec)
% 
% %Draw the Bode diagrams
% figure
% bode(L_lead)
% hold on
% bode(L_leadlag)
% grid
% 
% %Construct the closed-loop transfer function from disturbances to output
% disturbance_TF_lead = feedback(G,Gc_lead);
% disturbance_TF_leadlag=feedback(G,Gc_leadlag);
% 
% %Calculate disturbance transfer functions
% figure
% step(disturbance_TF_lead,50);
% hold on
% step(disturbance_TF_leadlag,50);
% grid