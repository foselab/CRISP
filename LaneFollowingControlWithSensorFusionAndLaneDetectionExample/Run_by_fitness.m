%% IN QUESTO FILE PRENDIAMO I RISULTATI FORNITI DALLA SIMULAZIONE CASUALE E RIESEGUIAMO LE 
%% SIMULAZIONI TENENDO CONTO DEL RISULTATO OTTENUTO DALLA FUNZIONE FITNESS

%% ordinamento dei dati secondo la fitness di Hecate

FileNameExcel = 'tabellarisultati.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separo l'intestazione dai dati reali 
header = raw(1, :); 
data = raw(2:end,:); 

% estraggo i valori contenuti nella colonna della fitness function 
Fitness_Hecate = cell2mat(data(:,3)); 

% ordino le righe in base al valore contenuto nella terza colonna, quella
% relativa alla fitness

[~, sortIdx] = sort(Fitness_Hecate);
sorted_Table = data(sortIdx, :); 

%% NOME DELLA SIMULAZIONE

modelname_simulation = 'LaneFollowingTestBenchExample';
                                                                        
%% ELENCO AUTOMOBILI DISPONIBILI (organizzato in un vettore di celle) 
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array

Vehicles_Parameters = {
    'Malibu.m',...          % VehicleId = 1
    %'HummerEV.m',...        % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    };

lenght_vehicles_array = length(Vehicles_Parameters);  %lunghezza array veicoli

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

Results_Table_by_Fitness = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);


%% SIMULAZIONE 

numero_iterazioni = size(sorted_Table,1); % il numero di iterazioni da eseguire corrisponde al numero di righe della tabella riordinata

 
for i = 1 : numero_iterazioni
    Vehicle_file_name = sorted_Table{i,2};  % leggo il nome del veicolo e 
    run(Vehicle_file_name);                 % ne eseguo il codice 

    Scenario_file_name = sorted_Table{i,1}; % estraggo il nome dello scenario
    
    % questo ciclo for mi serve per estrarre l'id dello scenario 
    for j=1 : lenght_scenarios_array
        if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % configurazione simulazione
    fprintf('CONFIGURAZIONE SIMULAZIONE\n');
    helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
    fprintf('SIMULAZIONE CORRETTAMENTE CONFIGURATA\n');
    

    % configurazione fitness function hecate
    fprintf('CONFIGURAZIONE HECATE\n'); 
    run("hecate\testComandi.m");                        
    fprintf('HECATE CORRETTAMENTE CONFIGURATO\n');

    %run simulazione
    fprintf('START SIMULATION --- Scenario: %s  Vehicle: %s \n', Scenario_file_name, Vehicle_file_name);
    [Out] = sim(modelname_simulation, 'ReturnWorkspaceOutputs', 'on');
    fprintf('SIMULAZIONE CONCLUSA \n');

        
    %salvataggio dati simulazione
    fprintf('SALVATAGGIO DATI\n');
    fit_values = Out.logsout{6}.Values.Data;
    fitness_simulation = fit_values(end);
    Results_Table_by_Fitness(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation};   
end


%% salvataggio dati in un file excel 

writetable(Results_Table_by_Fitness, 'tabellarisultatiHecate.xlsx');
    














