%% IN THIS FILE WE TAKE THE RESULTS PROVIDED BY THE STARTING SIMULATION AND RE-RUN THE SIMULATIONS IN 
%% THE ORDER SUGGESTED BY APDIS
% This way we can run simulations for the new
% configuration basing the order on the discontinuity value

%% ordinamento dei dati secondo la discontinuity

FileNameExcel = 'tabellarisultati_ACC_CONF_0.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separo l'intestazione dai dati reali 
header = raw(1, :); 
data = raw(2:end,:); 

% estraggo i valori contenuti nella colonna della discontinuity 
Discontinuity = cell2mat(data(:,5)); 

% ordino le righe in base al valore contenuto nella quinta colonna, quella
% relativa alla discontinuity

[~, sortIdx] = sort(Discontinuity,'descend');
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
    'curvaLunga',...                                    % scenarioId = 1
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 2
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 3
    'A4_Bergamo',...                                    % scenarioId = 4
    'Anaconda',...                                      % scenarioId = 5
    'ACC_01_ISO_TargetDiscriminationTest',...           % scenarioId = 6
    'LFACC_01_DoubleCurve_DecelTarget',...              % scenarioId = 7
    'ACC_02_ISO_AutoRetargetTest',...                   % scenarioId = 8
    'Highway_double_target',...                         % scenarioId = 9
    'FrenataBrusca',...                                 % scenarioId = 10
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
sz = [rows 5];
varTypes = ["string", "string", "double", "logical", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision", "Discontinuity"];

Results_Table_by_APDISC = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);


%% START OF SIMULATION
tic;  % start of timer
numero_casi_fail_trovati = 0; 

numero_iterazioni = size(sorted_Table,1); % the number of iterations to be performed must match the number of rows in the reordered table

 
for i = 1 : numero_iterazioni
    Vehicle_file_name = sorted_Table{i,2};  % vehicle name extraction 
    run(Vehicle_file_name);                 % run the code of the vehicle 
    
    %min_acceleration_CONF1 = 10/100 * min_acceleration;  %CONF1

    Scenario_file_name = sorted_Table{i,1};  % scenario name extraction
    
    % scenario id extraction 
    for j = 1 : length_scenarios_array
        if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % configurazione simulazione
    fprintf('CONFIGURAZIONE SIMULAZIONE\n');
    helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
    fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');
    

    % sim configuration
    fprintf('CONFIGURAZIONE HECATE\n'); 
    run("hecate\testComandi.m");                        
    fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');

    % run simulation
    fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
    [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
    fprintf('SIMULAZIONE CONCLUSA \n');

        
    % saving data
    fprintf('SALVATAGGIO DATI\n');
    fit_values = Out.logsout{6}.Values.Data;
    fitness_simulation = fit_values(end);

    if(fitness_simulation<0)
        numero_casi_fail_trovati = numero_casi_fail_trovati+1; 
    end
     
    Collision_values = Out.logsout{1}.Values.Data;
    Collision = Collision_values(end);

    relative_distance = Out.logsout{21}.Values.Data;
    r = diff(relative_distance);
    discontinuityMaxValue = max(abs(r));

    Results_Table_by_APDISC(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision, discontinuityMaxValue};

        
end

tempo_trascorso = toc;  % STOP TIMER

%% "TOTAL_FAULT_FOUND" column addition

total_fault_col = NaN(height(Results_Table_by_APDISC), 1);
total_fault_col(1) = numero_casi_fail_trovati;
Results_Table_by_APDISC.Total_Fault_Found = total_fault_col;

%% SAVING DATA 

writetable(Results_Table_by_APDISC, 'tabellarisultati_APDISC_CONF3.xlsx');

fprintf('Numero fault trovati in 133 simulazioni: %d\n', numero_casi_fail_trovati);

%% CREATION OF THE GRAPH

T = readtable('tabellarisultati_APDISC_CONF3.xlsx');
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
title('Grafico performance APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_APDISC_CONF_3.fig');
savefig(filename);









