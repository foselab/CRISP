%% IN THIS FILE WE TAKE THE RESULTS PROVIDED BY THE STARTING SIMULATION AND RE-RUN THE SIMULATIONS IN 
%% THE ORDER SUGGESTED BY THE FITNESS VALUE
% This way we can run simulations for the new
% configuration basing the order on the value of the fitness functions

%% sorting data according to Hecate's fitness

FileNameExcel = 'table_ACC_CONF_0.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separate the header from the actual data 
header = raw(1, :); 
data = raw(2:end,:); 

% extract the values ​​contained in the fitness function column 
Fitness_Hecate = cell2mat(data(:,3)); 

% order the rows based on the value contained in the third column, the one relating to fitness

[~, sortIdx] = sort(Fitness_Hecate);
sorted_Table = data(sortIdx, :); 

%% NAME OF THE SIMULATION MODEL

modelname_simulation = 'LaneFollowingTestBenchExample';
                                                                        
%% LIST OF AVAILABLE VEHICLES (organized in a cell vector)
Vehicles_Parameters = {
    'Malibu.m',...          % VehicleId = 1
    'Panda.m',...           % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    'Colorado.m',...        % VehicleId = 4
    'A4.m',...              % VehicleId = 5
    'Polo.m',...            % VehicleId = 6
    'Tcross.m',...          % VehicleId = 7
    
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

%% CREATION OF A EMPTY TABLE, CONFIGURED TO CONTAIN THE VALUES OF EACH CONFIGURATION
rows = length_scenarios_array * length_vehicles_array;
sz = [rows 4];
varTypes = ["string", "string", "double", "logical"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision"];

Results_Table_by_Fitness = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);


%% START OF SIMULATION 
tic;  % start of timer
num_failures = 0; 

num_iterations = size(sorted_Table,1); % the number of iterations to be performed must match the number of rows in the reordered table

 
for i = 1 : num_iterations
    Vehicle_file_name = sorted_Table{i,2};  % vehicle name extraction 
    run(Vehicle_file_name);                 % run the code of the vehicle 
    
    min_acceleration_V9_CONFIG1_fitness = 10/100 * min_acceleration;  

    Scenario_file_name = sorted_Table{i,1}; % scenario name extraction
    
    % scenario id extraction 
    for j = 1 : length_scenarios_array
        if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % sim configuration
    fprintf('CONFIGURATION SIM\n');
    helperLFSetUp(max_acceleration, min_acceleration_V9_CONFIG1_fitness, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
    fprintf('SIM CONFIGURATED\n');
    

    % fitness function hecate configuration
    fprintf('CONFIGURATION HECATE\n'); 
    run("hecate\testComandi.m");                        
    fprintf('HECATE CONFIGURATED\n');

    %run simulation
    fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
    [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
    fprintf('END SIMULATION \n');

        
    %saving data
    fprintf('SAVING DATA\n');
    fit_values = Out.logsout{6}.Values.Data;
    fitness_simulation = fit_values(end);

    if(fitness_simulation<0)
        num_failures = num_failures+1; 
    end
     
    Collision_values = Out.logsout{1}.Values.Data;
    Collision = Collision_values(end);
    Results_Table_by_Fitness(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision};

        
end

tempo_trascorso = toc;  % stop timer

%% "TOTAL_FAULT_FOUND" column addition

total_fault_col = NaN(height(Results_Table_by_Fitness), 1);
total_fault_col(1) = num_failures;
Results_Table_by_Fitness.Total_Fault_Found = total_fault_col;

%% SAVING DATA 

writetable(Results_Table_by_Fitness, 'tabellarisultatiHecate_CONF1_finale.xlsx');

fprintf('Number of faults detected in 133 simulations: %d\n', num_failures);

%% CREATION OF THE GRAPH

T = readtable('tabellarisultati_HECATE_CONF_2.xlsx');
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
title('Grafico performance HECATE');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici','grafico_hecate_CONF2.fig');
savefig(filename);









