%% IN QUESTO FILE PRENDIAMO I RISULTATI FORNITI DALLA SIMULAZIONE DI PARTENZA E RIESEGUIAMO LE 
%% SIMULAZIONI IN ORDINE CASUALE

%% LETTURA DATI

FileNameExcel = 'tabellarisultati_TEST_V9_CONF_0.xlsx'; 
[~, ~, raw] = xlsread(FileNameExcel); 

% separo l'intestazione dai dati reali 
header = raw(1, :); 
data = raw(2:end,:); 

%% NOME DELLA SIMULAZIONE

modelname_simulation = 'LaneFollowingTestBenchExample';

%% CREO 5 VETTORI CASUALI DA 70 ELEMENTI 

s = rng; 

rng('shuffle');                             % Usa il tempo di sistema per generare una sequenza diversa ogni volta
random_order_1 = randperm(70);
random_order_2 = randperm(70);
random_order_3 = randperm(70);
random_order_4 = randperm(70);
random_order_5 = randperm(70);
matrice_rand = [random_order_1;random_order_2;random_order_3;random_order_4;random_order_5];

rng(s);

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



%% SIMULAZIONE 
tic;  % Inizia il timer
numero_casi_fail_trovati = 0; 

numero_iterazioni = size(data,1); % il numero di iterazioni da eseguire corrisponde al numero di righe della tabella riordinata

for column = 1 : 5

    numero_casi_fail_trovati = 0; 
    %creo una tabella nuova ad ogni run
    rows = length_scenarios_array * length_vehicles_array;
    sz = [rows 4];
    varTypes = ["string", "string", "double", "logical"];
    varNames = ["Scenario", "Vehicle", "Fitness_Hecate", "Collision"];

    Results_Table_by_Random = table('Size', sz, 'VariableTypes',varTypes, 'VariableNames',varNames);

    for i = 1 : numero_iterazioni
        number = matrice_rand(column,i);
        Vehicle_file_name = data{number,2};  % leggo il nome del veicolo e 
        run(Vehicle_file_name);                 % ne eseguo il codice 
        min_acceleration_V9_CONFIG1_random = 10/100 * min_acceleration;  
    
        Scenario_file_name = data{number,1}; % estraggo il nome dello scenario
        
        % questo ciclo for mi serve per estrarre l'id dello scenario 
        for j=1 : length_scenarios_array
            if(strcmp(Scenario_Array_validi{j},Scenario_file_name))
                scenario_id = j;
                break;
            end
        end
    
        % configurazione simulazione
        fprintf('CONFIGURAZIONE SIMULAZIONE\n');
        helperLFSetUp(max_acceleration, min_acceleration_V9_CONFIG1_random, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, Scenario_file_name, scenario_id);
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
        Results_Table_by_Random(i,:)={Scenario_file_name, Vehicle_file_name, fitness_simulation, Collision};

    end
    
    
    % aggiunta colonna "TOTAL_FAULT_FOUND"
    total_fault_col = NaN(height(Results_Table_by_Random), 1);
    total_fault_col(1) = numero_casi_fail_trovati;
    Results_Table_by_Random.Total_Fault_Found = total_fault_col;
    
    % CREAZIONE TABELLA EXCEL
    filename = sprintf('tabellarisultatiRandom_CONF1_RUN_%d.xlsx',column);
    writetable(Results_Table_by_Random, filename);
end

tempo_trascorso = toc;  % Ferma il timer e salva il tempo trascorso

%% CREAZIONE GRAFICI 

%grafico 1
T = readtable('tabellarisultatiRandom_CONF1_RUN_1.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM1');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_random_1.fig');
savefig(filename);

%grafico 2
T = readtable('tabellarisultatiRandom_CONF1_RUN_2.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM2');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_random_2.fig');
savefig(filename);

%grafico 3
T = readtable('tabellarisultatiRandom_CONF1_RUN_3.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM3');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_random_3.fig');
savefig(filename);

%grafico 4
T = readtable('tabellarisultatiRandom_CONF1_RUN_4.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM4');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_random_4.fig');
savefig(filename);

%grafico 5
T = readtable('tabellarisultatiRandom_CONF1_RUN_5.xlsx');
vettore_failure = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario(i)=1;
    end
end

vettore_failure_binario = cumsum(vettore_failure_binario);

asse_x = 1:length(vettore_failure_binario);

figure; 
p=plot(asse_x,vettore_failure_binario);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_binario));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM5');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici','grafico_random_5.fig');
savefig(filename);



