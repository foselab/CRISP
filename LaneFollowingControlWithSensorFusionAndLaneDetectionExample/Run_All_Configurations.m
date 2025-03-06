 %% INTRODUZIONE
% QUESTO FILE SERVE PER ANDARE A RUNNARE IN UN CICLO TUTTE LE POSSIBILI
% COMBINAZIONI TRA AUTOMOBILI, SCENARI E COMPONENTISTICA DISPONIBILE.

modelname_simulation = 'LaneFollowingTestBenchExample';

%% ELENCO AUTOMOBILI DISPONIBILI (organizzato in un vettore di celle) 
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

lenght_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

%% ELENCO POSSIBILI SCENARI (organizzato in un vettore di celle)
% quando si aggiunge un nuovo scenario, nel file di setup bisogna inserire
% il tempo di simulazione e la velocità dell'ego vehicle 

  Scenario_Array_validi = {
    'curvaLunga',...                                    % scenarioId = 1
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 2
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 3
    'A4_Bergamo',...                                    % scenarioId = 4
    'Anaconda',...                                      % scenarioId = 5
    'ACC_01_ISO_TargetDiscriminationTest',...           % scenarioId = 6
    'LFACC_01_DoubleCurve_DecelTarget',...              % scenarioId = 7
    'ACC_02_ISO_AutoRetargetTest',...                   % scenarioId = 8
    'A7_Milano_Genova'...                               % scenarioId = 9
    
        };

lenght_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREAZIONE TABELLA VUOTA, CONFIGURATA PER CONTENERE I VALORI DI OGNI CONFIGURAZIONE
rows = lenght_scenarios_array * lenght_vehicles_array;
sz = [rows 3];
varTypes = ["string", "string", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% FUNZIONE CICLICA CHE VA A RUNNARE TUTTE LE POSSIBILI CONFIGURAZIONI

row_counter = 1;


for i = 1 : lenght_vehicles_array

    %configurazioni parametri veicolo
    run(Vehicles_Parameters{i});

    for j = 1 : lenght_scenarios_array       
        scenario_id = j;
        %configurazione simulazione
        fprintf('CONFIGURAZIONE SIMULAZIONE\n');
        helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j}, scenario_id);
        fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');

        %configurazione fitness function hecate
        fprintf('CONFIGURAZIONE HECATE\n'); 
        run("hecate\testComandi.m");                        
        fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');

        %run simulazione
        fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{j}, Vehicles_Parameters{i});
        [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
        fprintf('SIMULAZIONE CONCLUSA \n');

        %salvataggio dati simulazione
        fprintf('SALVATAGGIO DATI\n');
        Actual_Scenario_Name = Scenario_Array_validi{j};    
        Actual_Vehicle_Name = Vehicles_Parameters{i};
        fit_values = Out.logsout{6}.Values.Data;
        fitness_simulation = fit_values(end);
        Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name, fitness_simulation};   
        row_counter = row_counter+1;
    end

end 

% salvo i dati in un file excel 
writetable(Results_Table, 'tabellarisultati.xlsx');



