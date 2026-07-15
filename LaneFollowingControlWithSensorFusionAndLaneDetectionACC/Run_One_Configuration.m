%% USE THIS FILE IF YOU WANT TO TEST ONLY ONE SIMULATION
%% ENTER THE NAME OF THE SCENARIO AND THE NAME OF THE VEHICLE 
tic;  % star timer 
% parameter configuration, enter the car file name and the scenario file name 
modelname_simulation = 'LaneFollowingTestBenchExample';
fprintf('START CONFIGURATION PARAMETERS VEHICLES AND SCENARIO\n');
VEHICLE_NAME = 'Colorado.m'; 
SCENARIO_NAME = 'A15_LaSpezia_Parma';
id_scenario = 11;  % remember to change also this number (you can find the correct number in the HELPERLFSETUP file)
run(VEHICLE_NAME);
fprintf('DONE\n');

%HECATE configuration
fprintf('CONFIGURATION HECATE\n');
run("hecate\testComandi.m");
fprintf('HECATE CONFIGURATED\n');

%start simulation
fprintf('START SIMULATION\n');
%min_acceleration_CONF_1 = (20/100)*min_acceleration;
helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, SCENARIO_NAME, id_scenario);
[Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
fprintf('FINISH\n');

%print results 
plotLFResults(Out.logsout, time_gap, default_spacing);

%saving data
fit_values = Out.logsout{6}.Values.Data;
fitness_simulation = fit_values(end);
Collision_values = Out.logsout{1}.Values.Data;
Collision = Collision_values(end);

relative_distance = Out.logsout{21}.Values.Data;
r = diff(relative_distance);
discontinuityMaxValue = max(abs(r));
fprintf('DATA SAVED\n');

%print simulation result on screen 
fprintf('FITNESS OBTAINED: %d\n', fitness_simulation);
fprintf('DISCONTINUITY OBTAINED: %d\n', discontinuityMaxValue);

tempo_trascorso = toc;  % stop timer
disp(['TIME REQUIRED: ', num2str(tempo_trascorso), ' secondS']);
fprintf("Collision?: %d\n", Collision);
