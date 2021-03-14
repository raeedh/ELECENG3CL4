%% EXPERIMENT 1 FIGURES
kp = [0.5 1 2 3 4 5];
for i = kp
    % Servo Angle
    file_name = "Report/Figures/.fig/exp1_kp" + num2str(i) + ".fig";
    servo_fig = openfig(file_name);
    servo_fig.WindowState = 'maximized';
    title_name = "Experiment 1: Servo Angle";
    subtitle_name = "$k_p$ = " + num2str(i) + ", $\tau_d$ = 0.1745";
    servo_title = title(title_name);
    servo_subtitle = subtitle(subtitle_name,'interpreter','latex');
    xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
    servo_ax = gca; servo_ax.FontSize = 20;
    legend(servo_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
    set(gca, 'Units','normalized', 'Position',[0.07 0.1 0.9 0.8]);
    servo_fig.InvertHardcopy = 'off';
    file_name = "Report/Figures/exp1_kp" + num2str(i) + ".png";
    saveas(servo_fig, file_name);
    close(servo_fig);
end

%% EXPERIMENT 2 FIGURES
kp = [1.3314 1.7685 2.3395 3.3489];
for i = kp
    % Servo Angle (no td)
    file_name = "Report/Figures/.fig/exp2_kp" + num2str(i) + "_td0.fig";
    servo_fig0 = openfig(file_name);
    servo_fig0.WindowState = 'maximized';
    title_name = "Experiment 2: Servo Angle";
    subtitle_name = "$k_p$ = " + num2str(i)+ ", $\tau_d$ = 0";
    servo_title0 = title(title_name);
    servo_subtitle0 = subtitle(subtitle_name,'interpreter','latex');
    xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
    servo_ax0 = gca; servo_ax0.FontSize = 20;
    
    file_name = "Report/Figures/.fig/exp2_kp" + num2str(i) + "_td0.1745.fig";
    servo_fig1 = openfig(file_name);
    servo_fig1.WindowState = 'maximized';
    title_name = "Experiment 2: Servo Angle";
    subtitle_name = "$k_p$ = " + num2str(i)+ ", $\tau_d$ = 0.1745";
    servo_title1 = title(title_name);
    servo_subtitle1 = subtitle(subtitle_name,'interpreter','latex');
    xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
    servo_ax1 = gca; servo_ax1.FontSize = 20;
    
    combined_fig = figure;
    combined_fig.WindowState = 'maximized';
    combined_fig.Color = [0.16 0.16 0.16];
    tcl = tiledlayout(1,2);
    servo_ax0.Parent = tcl; servo_ax0.Layout.Tile = 1;
    servo_ax1.Parent = tcl; servo_ax1.Layout.Tile = 2;
    legend(servo_ax0,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
    legend(servo_ax1,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
    close(servo_fig0); close(servo_fig1);

    combined_fig.InvertHardcopy = 'off';
    file_name = "Report/Figures/exp2_kp" + num2str(i) + ".png";
    saveas(combined_fig, file_name);
    close(combined_fig);
end

%% EXPERIMENT 3 FIGURES
kp = [5 6 7];
kv = [0.1537 0.1718 0.1884];
for i = 1:3
    % Servo Angle
    file_name = "Report/Figures/.fig/exp3_kp" + num2str(kp(i)) + "_kv" + num2str(kv(i)) + ".fig";
    servo_fig = openfig(file_name);
    servo_fig.WindowState = 'maximized';
    title_name = "Experiment 3: Servo Angle";
    subtitle_name = "$k_p$ = " + num2str(kp(i)) + ", $k_v$ = " + num2str(kv(i))  + ", $\tau_d$ = 0.1745";
    servo_title = title(title_name);
    servo_subtitle = subtitle(subtitle_name,'interpreter','latex');
    xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
    servo_ax = gca; servo_ax.FontSize = 20;
    legend(servo_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
    set(gca, 'Units','normalized', 'Position',[0.07 0.1 0.9 0.8]);
    servo_fig.InvertHardcopy = 'off';
    file_name = "Report/Figures/exp3_kp" + num2str(kp(i)) + "_kv" + num2str(kv(i)) + ".png";
    saveas(servo_fig, file_name);
    close(servo_fig);
end

close all
clear
clc