%% INTRODUZIONE
% QUESTO FILE SERVE PER ANDARE A RUNNARE IN UN CICLO TUTTE LE POSSIBILI
% COMBINAZIONI TRA AUTOMOBILI, SCENARI E COMPONENTISTICA DISPONIBILE.

modelname_simulation = 'LaneFollowingTestBenchExample';
                                                                        
%% ELENCO AUTOMOBILI DISPONIBILI (organizzato in un vettore di celle) 
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array

Vehicles_Parameters = {
    'Malibu.m',...          % VehicleId = 1
    'HummerEV.m',...        % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    };

lenght_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

%% ELENCO POSSIBILI SCENARI (organizzato in un vettore di celle)

  Scenario_Array_validi = {
    'curvaLunga',...                                    % scenarioId = 1
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 2
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 3
        };

lenght_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREAZIONE TABELLA VUOTA, CONFIGURATA PER CONTENERE I VALORI DI OGNI CONFIGURAZIONE
rows = lenght_scenarios_array * lenght_vehicles_array;
sz = [rows 3];
varTypes = ["string", "string", "double"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate"];

Results_Table = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

%% FUNZIONE CICLICA CHE VA A RUNNARE TUTTE LE POSSIBILI CONFIGURAZIONI

% row_counter = 1;
% 
% 
% for i = 1 : lenght_vehicles_array
% 
%     %configurazioni parametri veicolo
%     run(Vehicles_Parameters{i});
% 
%     for j = 1 : lenght_scenarios_array       
%         scenario_id = j;
%         %configurazione simulazione
%         fprintf('CONFIGURAZIONE SIMULAZIONE\n');
%         helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_Array_validi{j}, scenario_id);
%         fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');
% 
%         %configurazione fitness function hecate
%         fprintf('CONFIGURAZIONE HECATE\n'); 
%         run("hecate\testComandi.m");                        
%         fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');
% 
%         %run simulazione
%         fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_Array_validi{j}, Vehicles_Parameters{i});
%         [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
%         fprintf('SIMULAZIONE CONCLUSA \n');
% 
%         %salvataggio dati simulazione
%         fprintf('SALVATAGGIO DATI\n');
%         Actual_Scenario_Name = Scenario_Array_validi{j};    
%         Actual_Vehicle_Name = Vehicles_Parameters{i};
%         fit_values = Out.logsout{6}.Values.Data;
%         fitness_simulation = fit_values(end);
%         Results_Table(row_counter,:)={Actual_Scenario_Name, Actual_Vehicle_Name, fitness_simulation};   
%         row_counter = row_counter+1;
%     end
% 
% end


%% NEL CASO VOLESSI TESTARE UNA SINGOLA CONFIGURAZIONE, COMMENTARE IL PARAGRAFO PRECEDENTE ED ESEGUIRE QUESTO 
%% INSERENDO IL NOME DELLO SCENARIO E DEL VEICOLO DESIDERATO

% configurazione parametri, si inserisce il nome del file dell'automobile e il nome del file dello scenario 
fprintf('INIZIO CONFIGURAZIONE PARAMETRI AUTO E SCENARIO\n');
VEHICLE_NAME = 'Camaro.m'; 
SCENARIO_NAME = 'LFACC_02_DoubleCurve_AutoRetarget';
id_scenario = 3;  % ricordarsi di cambiare anche questo
run(VEHICLE_NAME);
fprintf('PARAMETRI CORRETTAMENTE CONFIGURATI\n');

% configurazione di HECATE
fprintf('CONFIGURAZIONE HECATE\n');
run("hecate\testComandi.m");
fprintf('HECATE CONFIGURATO CORRETTAMENTE\n');

%inizio simulazione
fprintf('INIZIO SIMULAZIONE\n');
helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, SCENARIO_NAME, id_scenario);
[Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
fprintf('SIMULAZIONE CONCLUSA\n');

%stampo i risultati 
plotLFResults(Out.logsout, time_gap, default_spacing);

%salvataggio dati
fit_values = Out.logsout{6}.Values.Data;
fitness_simulation = fit_values(end);
fprintf('DATI SALVATI CORRETTAMENTE\n');

%stampa con risultato fitness simulazione
fprintf('LA SIMULAZIONE ESEGUITA HA OTTENUTO UN VALORE DI FITNESS: %d\n', fitness_simulation);



