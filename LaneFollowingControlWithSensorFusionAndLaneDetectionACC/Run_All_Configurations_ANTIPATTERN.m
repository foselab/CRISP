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
sz = [rows 5];
varTypes = ["string", "string", "double", "logical","double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision","Discontinuity"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% CYCLIC FUNCTION THAT GOES TO RUN ALL POSSIBLE CONFIGURATIONS
tic;  % start timer
row_counter = 1;


for i = 1 : length_vehicles_array

    %vehicle parameter configuration
    run(Vehicles_Parameters{i});
    
    for j = 1 : length_scenarios_array       
        scenario_id = j;
        %simulation configuration
        fprintf('CONFIGURING SIMULATION\n');
        helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j}, scenario_id);
        fprintf('SIMULATION CONFIGURATION SUCCESSFUL\n');

        %fitness function hecate configuration
        fprintf('CONFIGURING HECATE\n'); 
        run("hecate\testComandi.m");                        
        fprintf('HECATE CONFIGURATION SUCCESSFUL\n');

        %run simulation
        fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{j}, Vehicles_Parameters{i});
        [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
        fprintf('SIMULATION COMPLETE \n');

        %saving data
        fprintf('SAVING DATA\n');
        Actual_Scenario_Name = Scenario_Array_validi{j};    
        Actual_Vehicle_Name = Vehicles_Parameters{i};
        fit_values = Out.logsout{6}.Values.Data; 
        fitness_simulation = fit_values(end);  %fitness value
        Collision_values = Out.logsout{1}.Values.Data;
        Collision = Collision_values(end);

        relative_distance = Out.logsout{21}.Values.Data;
        r = diff(relative_distance);
        discontinuityMaxValue = max(abs(r)); %discontinuity value

        Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name, fitness_simulation, Collision, discontinuityMaxValue};   
        row_counter = row_counter+1;
    end

end 

% SAVING DATA in excel table 
writetable(Results_Table, 'tabellarisultati_ACC_CONF_0.xlsx');

tempo_trascorso = toc;  % stop timer
disp(['Tempo impiegato: ', num2str(tempo_trascorso), ' secondi']);


