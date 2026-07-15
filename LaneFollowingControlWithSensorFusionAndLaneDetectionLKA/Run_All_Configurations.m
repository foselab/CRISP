%% INTRODUCTION
% THIS FILE IS USED TO RUN ALL POSSIBLE
% COMBINATIONS OF CARS, SCENARIOS, AND AVAILABLE COMPONENTS IN A SINGLE CYCLE.

modelname_simulation = 'LaneFollowingTestBenchExample';

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

length_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

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

length_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREATION OF A EMPTY TABLE, CONFIGURED TO CONTAIN THE VALUES OF EACH CONFIGURATION 
rows = length_scenarios_array * length_vehicles_array;
sz = [rows 4];
varTypes = ["string", "string", "double", "logical"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% CYCLIC FUNCTION THAT GOES TO RUN ALL POSSIBLE CONFIGURATIONS
tic;  % Inizia il timer
row_counter = 1;


for i = 1 : length_vehicles_array

   %vehicle parameter configuration
    run(Vehicles_Parameters{i});
    
    for j = 1 : length_scenarios_array       
        scenario_id = j;
        
        fprintf('CONFIGURATION SIM\n');
        helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j}, scenario_id);
        fprintf('SIM CONFIGURATED\n');

        
        fprintf('CONFIGURATION HECATE\n'); 
        run("hecate\testComandi.m");                        
        fprintf('HECATE CONFIGURATED\n');

        
        fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{j}, Vehicles_Parameters{i});
        [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
        fprintf('END SIMULATION \n');

        
        fprintf('SAVING DATA\n');
        Actual_Scenario_Name = Scenario_Array_validi{j};    
        Actual_Vehicle_Name = Vehicles_Parameters{i};
        fit_values = Out.logsout{6}.Values.Data; 
        fitness_simulation = fit_values(end);
        Collision_values = Out.logsout{1}.Values.Data;
        Collision = Collision_values(end);
        Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name, fitness_simulation, Collision};   
        row_counter = row_counter+1;
    end

end 

 
writetable(Results_Table, 'table_LKA_CONF_0.xlsx');

tempo_trascorso = toc;  
disp(['Time required: ', num2str(tempo_trascorso), ' seconds']);


