%% EXPERIMENT 1 FIGURES

% Motor Voltage
motor_fig = openfig('Report/Figures/.fig/exp1_motor.fig');
motor_fig.WindowState = 'maximized';
motor_title = title('Experiment 1: Motor Voltage');
xlabel('Time (s)'); ylabel('Motor Voltage (V)');
motor_ax = gca; motor_ax.FontSize = 20;

% Servo Angle
servo_fig = openfig('Report/Figures/.fig/exp1_servo.fig');
servo_fig.WindowState = 'maximized';
servo_title = title('Experiment 1: Servo Angle');
xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
servo_ax = gca; servo_ax.FontSize = 20;

% Combined Figure
combined_fig = figure;
combined_fig.WindowState = 'maximized';
combined_fig.Color = [0.16 0.16 0.16];
tcl = tiledlayout(1,2);
motor_ax.Parent = tcl; motor_ax.Layout.Tile = 1;
servo_ax.Parent = tcl; servo_ax.Layout.Tile = 2;
legend(servo_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
close(motor_fig); close(servo_fig);

combined_fig.InvertHardcopy = 'off';
saveas(combined_fig, 'Report/Figures/exp1.png');
close(combined_fig);
clear

%% EXPERIMENT 2 FIGURES

frequencies = [0.5 1 2 3 3.06 4 5 6];
for freq = frequencies
    % Motor Voltage
    file_name = "Report/Figures/.fig/exp2_" + num2str(freq) + "_motor.fig";
    motor_fig = openfig(file_name);
    motor_fig.WindowState = 'maximized';
    title_name = "Experiment 2 (" + num2str(freq)+ " Hz): Motor Voltage";
    motor_title = title(title_name);
    xlabel('Time (s)'); ylabel('Motor Voltage (V)');
    motor_ax = gca; motor_ax.FontSize = 20;
    
    % Servo Angle
    file_name = "Report/Figures/.fig/exp2_" + num2str(freq) + "_servo.fig";
    servo_fig = openfig(file_name);
    servo_fig.WindowState = 'maximized';
    title_name = "Experiment 2 (" + num2str(freq)+ " Hz): Servo Angle";
    servo_title = title(title_name);
    xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
    servo_ax = gca; servo_ax.FontSize = 20;
    
    % Combined Figure
    combined_fig = figure;
    combined_fig.WindowState = 'maximized';
    combined_fig.Color = [0.16 0.16 0.16];
    tcl = tiledlayout(1,2);
    motor_ax.Parent = tcl; motor_ax.Layout.Tile = 1;
    servo_ax.Parent = tcl; servo_ax.Layout.Tile = 2;
    legend(servo_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
    close(motor_fig); close(servo_fig);
    combined_fig.InvertHardcopy = 'off';
    file_name = "Report/Figures/exp2_" + num2str(freq) + ".png";
    saveas(combined_fig, file_name);
    close(combined_fig);
end

clear
clc