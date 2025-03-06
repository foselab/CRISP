%% NEL CASO VOLESSI TESTARE UNA SINGOLA CONFIGURAZIONE
%% INSERENDO IL NOME DELLO SCENARIO E DEL VEICOLO DESIDERATO

% configurazione parametri, si inserisce il nome del file dell'automobile e il nome del file dello scenario 
modelname_simulation = 'LaneFollowingTestBenchExample';
fprintf('INIZIO CONFIGURAZIONE PARAMETRI AUTO E SCENARIO\n');
VEHICLE_NAME = 'Panda.m'; 
SCENARIO_NAME = 'FrenataBrusca';
id_scenario = 10;  % ricordarsi di cambiare anche questo
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