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

length_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

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

length_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREAZIONE TABELLA VUOTA, CONFIGURATA PER CONTENERE I VALORI DI OGNI CONFIGURAZIONE
rows = length_scenarios_array * length_vehicles_array;
sz = [rows 5];
varTypes = ["string", "string", "double", "logical","double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision","Discontinuity"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% FUNZIONE CICLICA CHE VA A RUNNARE TUTTE LE POSSIBILI CONFIGURAZIONI
tic;  % Inizia il timer
row_counter = 1;


for i = 1 : length_vehicles_array

    %configurazioni parametri veicolo
    run(Vehicles_Parameters{i});
    
    min_acceleration_V9_CONFIG1 = 10/100 * min_acceleration;
    for j = 1 : length_scenarios_array       
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
        fitness_simulation = fit_values(end);  %estraggo valore fitness
        Collision_values = Out.logsout{1}.Values.Data;
        Collision = Collision_values(end);

        relative_distance = Out.logsout{21}.Values.Data;
        r = diff(relative_distance);
        discontinuityMaxValue = max(abd(r));

        Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name, fitness_simulation, Collision, discontinuityMaxValue};   
        row_counter = row_counter+1;
    end

end 

% salvo i dati in un file excel 
writetable(Results_Table, 'tabellarisultati_ACC_CONF_0_finale.xlsx');

tempo_trascorso = toc;  % Ferma il timer e salva il tempo trascorso
disp(['Tempo impiegato: ', num2str(tempo_trascorso), ' secondi']);


