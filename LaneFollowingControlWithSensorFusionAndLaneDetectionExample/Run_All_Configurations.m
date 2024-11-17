%% INTRODUZIONE
% QUESTO FILE SERVE PER ANDARE A RUNNARE IN UN CICLO TUTTE LE POSSIBILI
% COMBINAZIONI TRA AUTOMOBILI, SCENARI E COMPONENTISTICA DISPONIBILE.

modelname_simulation = 'LaneFollowingTestBenchExample';

%% elenco automobili disponibili (organizzato in un vettore di celle) 
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array

Vehicles_Parameters = {
    'HummerEV.m',...        % VehicleId = 1
    'Malibu.m',...          % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    };

lenght_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

%% elenco possibili scenari (organizzato in un vettore di celle)
 % Scenario_Array_validi = {
 %    'scenarioOstacoloSuStrada',...                     % scenarioId = 7
 %    'LFACC_04_Curve_CutInOut',...                      % scenarioId = 8
 %    'selvinotest',...                                  % scenarioId = 9
 %    };

  Scenario_Array_validi = {
    'LFACC_04_Curve_CutInOut',...                   
    };
lenght_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% creazione array di celle vuoto, configurato per contenere i valori di ogni configurazione
rows = lenght_scenarios_array * lenght_vehicles_array;
sz = [rows 3];
varTypes = ["String", "String", "Double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% funzione ciclica che va a runnare tutte le possibili configurazioni

row_counter = 1;


for i = 1 : lenght_vehicles_array

    %configurazioni parametri veicolo
    run(Vehicles_Parameters{i});

    for j = 1 : lenght_scenarios_array       

        %configurazione fitness function hecate
        fprintf('Run comandi hecate\n'); 
        run("hecate\testComandi.m");                        
        fprintf('Hecate correttamente configurato');

        %run simulazione
        fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{i}, Vehicles_Parameters{i});
        helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j});
        sim(modelname_simulation);
        fprintf('SIMULAZIONE CONCLUSA \n');

        %salvataggio dati simulazione
        fprintf('SALVATAGGIO DATI\n');
        Actual_Name_Scenario = Scenario_Array_validi{j};
        Actual_Vehicle_Name = Vehicles_Parameters{i};
        Results_Table(row_counter,:)={Actual_Name_Scenario, Actual_Vehicle_Name,};   %CONTINUA DA QUI, DEVI SALVARTI IL NUMERO DELLA FITNESS
    end
    
end