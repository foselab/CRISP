%% IN THIS FILE WE TAKE THE RESULTS PROVIDED BY THE STARTING SIMULATION AND RE-RUN THE SIMULATIONS IN 
%% THE ORDER SUGGESTED BY THE FITNESS VALUE
% This way we can run simulations for the new
% configuration basing the order on the value of the fitness functions

%% sorting data according to Hecate's fitness

FileNameExcel = 'tabellarisultati_LKA_CONF_0.xlsx'; 
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
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array

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
    'LFACC_01_DoubleCurve_DecelTarget',...              % scenarioId = 1
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 2
    'LFACC_03_DoubleCurve_StopnGo',...                  % scenarioId = 3
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 4
    'LFACC_05_Curve_CutInOut_TooClose',...              % scenarioId = 5
    'Anaconda',...                                      % scenarioId = 6
    'A26_Autostrada_Trafori',...                        % scenarioId = 7
    'Overseas_Hwy',...                                  % scenarioId = 8
    'Pacific_Coast_Highway',...                         % scenarioId = 9
    'Sea_Sky_Hwy',...                                   % scenarioId = 10
    'Trans_Canada_Hwy',...                              % scenarioId = 11
    'A8_Stoccarda_Monaco',...                           % scenarioId = 12
    'I_81_Hwy',...                                      % scenarioId = 13
    
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
numero_casi_fail_trovati = 0; 

numero_iterazioni = size(sorted_Table,1); % the number of iterations to be performed must match the number of rows in the reordered table
 
for i = 1 : numero_iterazioni
    Vehicle_file_name = sorted_Table{i,2};  % vehicle name extraction 
    run(Vehicle_file_name);                 % run the code of the vehicle 

    min_steering_CONF1 = min_steering*10/100; %OTA
    max_steering_CONF1 = max_steering*10/100; %OTA

    Scenario_file_name = sorted_Table{i,1}; % scenario name extraction
    
    % scenario id extraction 
    for j = 1 : length_scenarios_array
        if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % sim configuration
    fprintf('CONFIGURAZIONE SIMULAZIONE\n');
    helperLFSetUp(max_acceleration, min_acceleration, max_steering_CONF1, min_steering_CONF1, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
    fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');
    

    % fitness function hecate configuration
    fprintf('CONFIGURAZIONE HECATE\n'); 
    run("hecate\testComandi.m");                        
    fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');

    %run simulation
    fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
    [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
    fprintf('SIMULAZIONE CONCLUSA \n');

        
    %saving data
    fprintf('SALVATAGGIO DATI\n');
    fit_values = Out.logsout{6}.Values.Data;
    fitness_simulation = fit_values(end);

    if(fitness_simulation<0)
        numero_casi_fail_trovati = numero_casi_fail_trovati+1; 
    end
     
    Collision_values = Out.logsout{1}.Values.Data;
    Collision = Collision_values(end);
    Results_Table_by_Fitness(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision};

        
end

tempo_trascorso = toc;  % stop timer

%% "TOTAL_FAULT_FOUND" column addition

total_fault_col = NaN(height(Results_Table_by_Fitness), 1);
total_fault_col(1) = numero_casi_fail_trovati;
Results_Table_by_Fitness.Total_Fault_Found = total_fault_col;

%% SAVING DATA

writetable(Results_Table_by_Fitness, 'tabellarisultati_LKA_CONF_2_HECATE.xlsx');

fprintf('Numero fault trovati in 91 simulazioni: %d\n', numero_casi_fail_trovati);

%% CREATION OF THE GRAPH 

T = readtable('tabellarisultati_LKA_CONF3_HECATE.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance HECATE');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi LKA\grafici\OTA3','grafico_hecate_CONF3.fig');
savefig(filename);









