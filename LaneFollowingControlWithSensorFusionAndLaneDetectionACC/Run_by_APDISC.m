%% IN THIS FILE WE TAKE THE RESULTS PROVIDED BY THE STARTING SIMULATION AND RE-RUN THE SIMULATIONS IN 
%% THE ORDER SUGGESTED BY APDISC
% This way we can run simulations for the new
% configuration basing the order on the discontinuity value

%% sorting data according to discontinuity

FileNameExcel = 'tabellarisultati_ACC_CONF_0.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separate the header from the actual data 
header = raw(1, :); 
data = raw(2:end,:); 

% extract the values ​​contained in the discontinuity function column 
Discontinuity = cell2mat(data(:,5)); 

% order the rows based on the value contained in the third column, the one
% relating to discontinuity

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

  Valid_Scenario_Array = {
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

length_scenarios_array = length(Valid_Scenario_Array);         

%% CREATION OF A EMPTY TABLE, CONFIGURED TO CONTAIN THE VALUES OF EACH CONFIGURATION
rows = length_scenarios_array * length_vehicles_array;
sz = [rows 5];
varTypes = ["string", "string", "double", "logical", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision", "Discontinuity"];

Results_Table_by_APDISC = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);


%% START OF SIMULATION
tic;  % start of timer
num_failures = 0; 

num_iterations = size(sorted_Table,1); % the number of iterations to be performed must match the number of rows in the reordered table

 
for i = 1 : num_iterations
    Vehicle_file_name = sorted_Table{i,2};  % vehicle name extraction 
    run(Vehicle_file_name);                 % run the code of the vehicle 
    
    %min_acceleration_CONF1 = 10/100 * min_acceleration;  %CONF1

    Scenario_file_name = sorted_Table{i,1};  % scenario name extraction
    
    % scenario id extraction 
    for j = 1 : length_scenarios_array
        if(strcmp(Valid_Scenario_Array{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % CONFIGURING SIMULATION
    fprintf('CONFIGURING SIMULATION\n');
    helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
    fprintf('SIMULATION CONFIGURATION SUCCESSFUL\n');
    

    % sim configuration
    fprintf('CONFIGURING HECATE\n'); 
    run("hecate\testComandi.m");                        
    fprintf('HECATE CONFIGURATION SUCCESSFUL\n');

    % run simulation
    fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
    [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
    fprintf('SIMULATION COMPLETE \n');

        
    % saving data
    fprintf('SAVING DATA\n');
    fit_values = Out.logsout{6}.Values.Data;
    fitness_simulation = fit_values(end);

    if(fitness_simulation<0)
        num_failures = num_failures+1; 
    end
     
    Collision_values = Out.logsout{1}.Values.Data;
    Collision = Collision_values(end);

    relative_distance = Out.logsout{21}.Values.Data;
    r = diff(relative_distance);
    discontinuityMaxValue = max(abs(r));

    Results_Table_by_APDISC(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision, discontinuityMaxValue};

        
end

elapsed_time = toc;  % STOP TIMER

%% "TOTAL_FAULT_FOUND" column addition

total_fault_col = NaN(height(Results_Table_by_APDISC), 1);
total_fault_col(1) = num_failures;
Results_Table_by_APDISC.Total_Fault_Found = total_fault_col;

%% SAVING DATA 

writetable(Results_Table_by_APDISC, 'tabellarisultati_APDISC_CONF3.xlsx');

fprintf('Numero fault trovati in 133 Simulations: %d\n', num_failures);

%% CREATION OF THE GRAPH

T = readtable('tabellarisultati_APDISC_CONF3.xlsx');
failure_vector = double(T{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector = zeros(1,length(failure_vector));
for i=1:length(failure_vector)
    if(failure_vector(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

x_axis = 1:length(binary_failure_vector);

figure; 
p=plot(x_axis,binary_failure_vector);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(binary_failure_vector));

xlabel('Simulations');
ylabel('Failure');
title('AP-DISC Performance');
grid on;
filepath = fileparts(mfilename('fullpath'));
filename = fullfile(filepath, '\plots','grafico_APDISC_CONF_3.fig');
savefig(filename);









