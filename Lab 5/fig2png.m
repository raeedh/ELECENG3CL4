% plots = ["step", "ramp", "dist"];
compensator = ["lead", "leadlag"];

%% Step Response
for i = compensator
	file_name = "Report/Figures/.fig/step_" + i + ".fig";
	step_fig = openfig(file_name);
	step_fig.WindowState = 'maximized';
	title_name = "Step Response";
	switch i
		case "lead"
			subtitle_name = "Lead Compensator";
		case "leadlag"
			subtitle_name = "Lead-Lag Compensator";
	end
	step_title = title(title_name);
	step_subtitle = subtitle(subtitle_name);
	xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
	step_ax = gca; step_ax.FontSize = 20;
	legend(step_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
	set(gca, 'Units','normalized', 'Position',[0.07 0.1 0.9 0.8]);
	step_fig.InvertHardcopy = 'off';
	file_name = "Report/Figures/step_" + i + ".png";
	saveas(step_fig, file_name);
	close(step_fig);
end

%% Step Disturbance Response
for i = compensator
	file_name = "Report/Figures/.fig/dist_" + i + ".fig";
	dist_fig = openfig(file_name);
	dist_fig.WindowState = 'maximized';
	title_name = "Step Disturbance Response";
	switch i
		case "lead"
			subtitle_name = "Lead Compensator";
		case "leadlag"
			subtitle_name = "Lead-Lag Compensator";
	end
	dist_title = title(title_name);
	dist_subtitle = subtitle(subtitle_name);
	xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
	dist_ax = gca; dist_ax.FontSize = 20;
	legend(dist_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
	set(gca, 'Units','normalized', 'Position',[0.07 0.1 0.9 0.8]);
	dist_fig.InvertHardcopy = 'off';
	file_name = "Report/Figures/dist_" + i + ".png";
	saveas(dist_fig, file_name);
	close(dist_fig);
end

%% Ramp Response
for i = compensator
	file_name = "Report/Figures/.fig/ramp_" + i + ".fig";
	ramp_fig = openfig(file_name);
	ramp_fig.WindowState = 'maximized';
	title_name = "Ramp Response";
	switch i
		case "lead"
			subtitle_name = "Lead Compensator";
		case "leadlag"
			subtitle_name = "Lead-Lag Compensator";
	end
	ramp_title = title(title_name);
	ramp_subtitle = subtitle(subtitle_name);
	xlabel('Time (s)'); ylabel('Servo Angle (degrees)');
	ramp_ax = gca; ramp_ax.FontSize = 20;
	legend(ramp_ax,{'Input Signal', 'Output Signal'}, 'TextColor', '#AFAFAF');
	set(gca, 'Units','normalized', 'Position',[0.07 0.1 0.9 0.8]);
	ramp_fig.InvertHardcopy = 'off';
	file_name = "Report/Figures/ramp_" + i + ".png";
	saveas(ramp_fig, file_name);
	close(ramp_fig);
end

close all
clear
clc