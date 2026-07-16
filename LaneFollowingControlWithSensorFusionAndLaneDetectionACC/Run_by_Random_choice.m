%% IN THIS FILE WE TAKE THE RESULTS PROVIDED BY THE STARTING SIMULATION AND RE-RUN THE SIMULATIONS IN RANDOM ORDER
%% EXTRACTING DATA FROM THE TABLE

FileNameExcel = 'tabellarisultati_TEST_V9_CONF_0_finale.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separate the header from the actual data
header = raw(1, :); 
data = raw(2:end,:); 

%% NAME OF THE MODEL SIMULATION

modelname_simulation = 'LaneFollowingTestBenchExample';

%% CREATION OF 5 RANDOM VECTORS OF 133 ELEMENTS

s = rng; 

rng('shuffle');                            
random_order_1 = randperm(133);
random_order_2 = randperm(133);
random_order_3 = randperm(133);
random_order_4 = randperm(133);
random_order_5 = randperm(133);
matrice_rand = [random_order_1;random_order_2;random_order_3;random_order_4;random_order_5];

rng(s);

%% LIST OF AVAILABLE VEHICLES (organized in a cell vector)
Vehicles_Parameters = {
    'Malibu.m',...          % VehicleId = 1
    'Panda.m',...           % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    'Colorado.m',...        % VehicleId = 4
    'A4.m',...              % VehicleId = 5
    'Polo.m',...            % VehicleId = 6
    'Tcross',...            % VehicleId = 7
    
    };

length_vehicles_array = length(Vehicles_Parameters);           

%% LIST OF AVAILABLE SCENARIOS (organized in a cell vector)
  Scenario_Array_validi = {
    'LongTurn',...                                    % scenarioId = 1
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 2
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 3
    'A4_Bergamo',...                                    % scenarioId = 4
    'Anaconda',...                                      % scenarioId = 5
    'ACC_01_ISO_TargetDiscriminationTest',...           % scenarioId = 6
    'LFACC_01_DoubleCurve_DecelTarget',...              % scenarioId = 7
    'ACC_02_ISO_AutoRetargetTest',...                   % scenarioId = 8
    'Highway_double_target',...                         % scenarioId = 9
    'SuddenBraking',...                                 % scenarioId = 10
    'A15_LaSpezia_Parma',...                            % scenarioId = 11
    'A26_Autostrada_Trafori',...                        % scenarioId = 12
    'Pacific_Coast_Highway',...                         % scenarioId = 13
    'Trans_Canada_Hwy',...                              % scenarioId = 14
    'A8_Stoccarda_Monaco',...                           % scenarioId = 15
    'Overseas_Hwy',...                                  % scenarioId = 16
    'Sea_Sky_Hwy',...                                   % scenarioId = 17
    'Queen_Elizabeth_Way_Oakville',...                  % scenarioId = 18
    'Las_Vegas_Freeway',...                             % scenarioId = 19
    
        };

length_scenarios_array = length(Scenario_Array_validi);   



%% START OF SIMULATION 
tic;  % start of timer
num_failures = 0; 

num_iterations = size(data,1); % the number of iterations to be performed must match the number of rows in the reordered table

for column = 1 : 5

    num_failures = 0; 
    %new table for each run
    rows = length_scenarios_array * length_vehicles_array;
    sz = [rows 4];
    varTypes = ["string", "string", "double", "logical"];
    varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision"];

    Results_Table_by_Random = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

    for i = 1 : num_iterations
        number = matrice_rand(column,i);
        Vehicle_file_name = data{number,2};  % vehicle name extraction 
        run(Vehicle_file_name);                 % run the code of the vehicle 
        min_acceleration_V9_CONFIG1_random = 10/100 * min_acceleration;  
    
        Scenario_file_name = data{number,1}; % scenario name extraction
        
        % scenario id extraction 
        for j=1 : length_scenarios_array
            if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
                scenario_id = j;
                break;
            end
        end
    
        % sim configuration
        fprintf('CONFIGURING SIMULATION\n');
        helperLFSetUp(max_acceleration, min_acceleration_V9_CONFIG1_random, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
        fprintf('SIMULATION CONFIGURATION SUCCESSFUL\n');
        
    
        % fitness function hecate configuration
        fprintf('CONFIGURING HECATE\n'); 
        run("hecate\testComandi.m");                        
        fprintf('HECATE CONFIGURATION SUCCESSFUL\n');
    
        %run simulation
        fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
        [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
        fprintf('SIMULATION COMPLETE \n');
    
            
        %saving data
        fprintf('SAVING DATA\n');
        fit_values = Out.logsout{6}.Values.Data;
        fitness_simulation = fit_values(end);
    
        if(fitness_simulation<0)
            num_failures = num_failures+1; 
        end
         
        Collision_values = Out.logsout{1}.Values.Data;
        Collision = Collision_values(end);
        Results_Table_by_Random(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision};

    end
    
    
    % "TOTAL_FAULT_FOUND" column addition
    total_fault_col = NaN(height(Results_Table_by_Random), 1);
    total_fault_col(1) = num_failures;
    Results_Table_by_Random.Total_Fault_Found = total_fault_col;
    
    % CREATION OF THE EXCEL TABLE WITH THE RESULTS
    filename = sprintf('tabellarisultatiRandom_CONF1_RUN_%d_finale.xlsx',column);
    writetable(Results_Table_by_Random, filename);
end

tempo_trascorso = toc;  % stop timer

%% CREATION OF THE GRAPHS

% GRAPH 1
T = readtable('tabellarisultati_RANDOM1_CONF_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

asse_x = 1:length(binary_failure_vector);

figure; 
p=plot(asse_x,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM1');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA2','grafico_random_1_CONF2.fig');
savefig(filename);

% GRAPH 2
T = readtable('tabellarisultati_RANDOM2_CONF_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

asse_x = 1:length(binary_failure_vector);

figure; 
p=plot(asse_x,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM2');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA2','grafico_random_2_CONF2.fig');
savefig(filename);

% GRAPH 3
T = readtable('tabellarisultati_RANDOM3_CONF_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

asse_x = 1:length(binary_failure_vector);

figure; 
p=plot(asse_x,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM3');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA2','grafico_random_3_CONF2.fig');
savefig(filename);

% GRAPH 4
T = readtable('tabellarisultati_RANDOM4_CONF_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

asse_x = 1:length(binary_failure_vector);

figure; 
p=plot(asse_x,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM4');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA2','grafico_random_4_CONF2.fig');
savefig(filename);

% GRAPH 5
T = readtable('tabellarisultati_RANDOM5_CONF_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

asse_x = 1:length(binary_failure_vector);

figure; 
p=plot(asse_x,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM5');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA2','grafico_random_5_CONF2.fig');
savefig(filename);



