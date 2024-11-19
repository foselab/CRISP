%% INTRODUZIONE
% QUESTO FILE SERVE PER ANDARE A RUNNARE IN UN CICLO TUTTE LE POSSIBILI
% COMBINAZIONI TRA AUTOMOBILI, SCENARI E COMPONENTISTICA DISPONIBILE.

modelname_simulation = 'LaneFollowingTestBenchExample';

%% ELENCO AUTOMOBILI DISPONIBILI (organizzato in un vettore di celle) 
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array

Vehicles_Parameters = {
    'HummerEV.m',...        % VehicleId = 1
    'Malibu.m',...          % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    };

lenght_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

%% ELENCO POSSIBILI SCENARI (organizzato in un vettore di celle)
 % Scenario_Array_validi = {
 %    'scenarioOstacoloSuStrada',...                     % scenarioId = 7
 %    'LFACC_04_Curve_CutInOut',...                      % scenarioId = 8
 %    'selvinotest',...                                  % scenarioId = 9
 %    };

  Scenario_Array_validi = {
    'LFACC_04_Curve_CutInOut',...                   
    };
lenght_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREAZIONE TABELLA VUOTA, CONFIGURATA PER CONTENERE I VALORI DI OGNI CONFIGURAZIONE
rows = lenght_scenarios_array * lenght_vehicles_array;
sz = [rows 3];
varTypes = ["string", "string", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

% %% funzione ciclica che va a runnare tutte le possibili configurazioni
% 
% row_counter = 1;
% 
% 
% for i = 1 : lenght_vehicles_array
% 
%     %configurazioni parametri veicolo
%     run(Vehicles_Parameters{i});
% 
%     for j = 1 : lenght_scenarios_array       
% 
%         %configurazione simulazione
%         fprintf('CONFIGURAZIONE SIMULAZIONE\n');
%         helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j});
%         fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');
% 
%         %configurazione fitness function hecate
%         fprintf('CONFIGURAZIONE HECATE\n'); 
%         run("hecate\testComandi.m");                        
%         fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');
% 
%         %run simulazione
%         fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{i}, Vehicles_Parameters{i});
%         sim(modelname_simulation);
%         fprintf('SIMULAZIONE CONCLUSA \n');
% 
%         %salvataggio dati simulazione
%         % fprintf('SALVATAGGIO DATI\n');
%         % Actual_Scenario_Name = Scenario_Array_validi{j};
%         % Actual_Vehicle_Name = Vehicles_Parameters{i};
%         % Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name,};   %CONTINUA DA QUI, DEVI SALVARTI IL NUMERO DELLA FITNESS
%         % row_counter = row_counter+1;
%     end
% 
% end


%% NEL CASO VOLESSI TESTARE UNA SINGOLA CONFIGURAZIONE, COMMENTARE IL PARAGRAFO PRECEDENTE ED ESEGUIRE QUESTO 
%  INSERENDO IL NOME DELLO SCENARIO E DEL VEICOLO DESIDERATO

fprintf('STARTING SIMULATION\n');
VEHICLE_NAME = 'Camaro.m'; 
SCENARIO_NAME = 'LFACC_04_Curve_CutInOut';
run(VEHICLE_NAME);
fprintf('CONFIGURAZIONE HECATE\n');
run("hecate\testComandi.m");
fprintf('HECATE CONFIGURATO CORRETTAMENTE\n');
helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, SCENARIO_NAME);
simOut = sim(modelname_simulation);  
%  QUESTO è IL COMANDO CHE TI SERVE PER REGISTRARE I VALORI IN USCITA,
%  CAPISCI MEGLIO COME FUNZIONA, TEORIACAMENTE TUTTI QUELI INPUNT NON TI
%  SERVONO, TI SERVE SOLO IL NOME DEL MODELLO.
%[T, XT, YT] = sim(inputModel, [0 staliro_SimulationTime], simopt, [steptime, InpSignal]); 

fprintf('SIMULAZIONE CONCLUSA\n');

