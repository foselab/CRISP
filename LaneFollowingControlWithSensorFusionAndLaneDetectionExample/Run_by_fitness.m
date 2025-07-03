%% IN QUESTO FILE PRENDIAMO I RISULTATI FORNITI DALLA SIMULAZIONE DI PARTENZA E RIESEGUIAMO LE 
%% SIMULAZIONI TENENDO CONTO DEL RISULTATO OTTENUTO DALLA FUNZIONE FITNESS
% in questo modo possiamo eseguire le simulazioni per la nuova
% configurazione basando l'ordine sul valore delle funzioni fitness

%% ordinamento dei dati secondo la fitness di Hecate

FileNameExcel = 'tabellarisultati_TEST_V9_CONF_0.xlsx'; 
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
    'Panda.m',...           % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    'Colorado.m',...        % VehicleId = 4
    'A4.m',...              % VehicleId = 5
    'Polo.m',...            % VehicleId = 6
    'Tcross',...            % VehicleId = 7
    
    };

length_vehicles_array = length(Vehicles_Parameters);             %lunghezza array veicoli

%% ELENCO POSSIBILI SCENARI (organizzato in un vettore di celle)

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
    
        };

length_scenarios_array = length(Scenario_Array_validi);          %lunghezza array scenari validi

%% CREAZIONE TABELLA VUOTA, CONFIGURATA PER CONTENERE I VALORI DI OGNI CONFIGURAZIONE
rows = length_scenarios_array * length_vehicles_array;
sz = [rows 4];
varTypes = ["string", "string", "double", "logical"];
varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision"];

Results_Table_by_Fitness = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);


%% SIMULAZIONE 
tic;  % Inizia il timer
numero_casi_fail_trovati = 0; 

numero_iterazioni = size(sorted_Table,1); % il numero di iterazioni da eseguire corrisponde al numero di righe della tabella riordinata

 
for i = 1 : numero_iterazioni
    Vehicle_file_name = sorted_Table{i,2};  % leggo il nome del veicolo e 
    run(Vehicle_file_name);                 % ne eseguo il codice 
    
    min_acceleration_V9_CONFIG1_fitness = 10/100 * min_acceleration;  

    Scenario_file_name = sorted_Table{i,1}; % estraggo il nome dello scenario
    
    % questo ciclo for mi serve per estrarre l'id dello scenario 
    for j = 1 : length_scenarios_array
        if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
            scenario_id = j;
            break;
        end
    end

    % configurazione simulazione
    fprintf('CONFIGURAZIONE SIMULAZIONE\n');
    helperLFSetUp(max_acceleration, min_acceleration_V9_CONFIG1_fitness, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
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

    if(fitness_simulation<0)
        numero_casi_fail_trovati = numero_casi_fail_trovati+1; 
    end
     
    Collision_values = Out.logsout{1}.Values.Data;
    Collision = Collision_values(end);
    Results_Table_by_Fitness(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision};

        
end

tempo_trascorso = toc;  % Ferma il timer e salva il tempo trascorso

%% AGGIUNTA COLONNA "Total_Fault_Found"

total_fault_col = NaN(height(Results_Table_by_Fitness), 1);
total_fault_col(1) = numero_casi_fail_trovati;
Results_Table_by_Fitness.Total_Fault_Found = total_fault_col;

%% SALVATAGGIO DATI 

writetable(Results_Table_by_Fitness, 'tabellarisultatiHecate_CONF1.xlsx');

fprintf('Numero fault trovati in 70 simulazioni: %d\n', numero_casi_fail_trovati);

%% CREAZIONE GRAFICO 

T = readtable('tabellarisultatiHecate_CONF1.xlsx');
vettore_collisioni = double(T{1:end, 4}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_collisioni_cumulativo = cumsum(vettore_collisioni);

asse_x = 1:length(vettore_collisioni_cumulativo);

figure; 
p=plot(asse_x,vettore_collisioni_cumulativo);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_collisioni_cumulativo));

xlabel('Simulazioni');
ylabel('Collisioni');
title('Grafico performance HECATE');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_hecate.fig');
savefig(filename);









