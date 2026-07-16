%% IF YOU WANT TO TEST A SINGLE CONFIGURATION BY ENTERING THE NAME OF 
%% THE SCENARIO AND THE DESIRED VEHICLE
tic;  % start timer
% parameter configuration, enter the car file name and the scenario file name 
modelname_simulation = 'LaneFollowingTestBenchExample';
fprintf('START CONFIGURATION PARAMETERS VEHICLES AND SCENARIO\n');
VEHICLE_NAME = 'Malibu.m'; 
SCENARIO_NAME = 'I_81_Hwy';
id_scenario = 13;  % remember to change also this number (you can find the correct number in the HELPERLFSETUP file)
run(VEHICLE_NAME);
fprintf('DONE\n');

%HECATE configuration
fprintf('CONFIGURATION HECATE\n');
run("hecate\testComandi.m");
fprintf('HECATE CONFIGURATED\n');

%start simulation
fprintf('START SIMULATION\n');
min_steering_CONF1 = min_steering*10/100; %OTA
max_steering_CONF1 = max_steering*10/100; %OTA
helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, SCENARIO_NAME, id_scenario);
[Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
fprintf('END SIMULATION\n');

%print results 
plotLFResults(Out.logsout, time_gap, default_spacing);

%saving data
fit_values = Out.logsout{6}.Values.Data;
fitness_simulation = fit_values(end);
Collision_values = Out.logsout{1}.Values.Data;
Collision = Collision_values(end);
fprintf('DATA SAVED\n');

%print simulation result on screen
fprintf('FITNESS OBTAINES: %d\n', fitness_simulation);

elapsed_time = toc;  % stop timer
disp(['Time required: ', num2str(elapsed_time), ' seconds']);
fprintf("Collision?: %d\n", Collision);
