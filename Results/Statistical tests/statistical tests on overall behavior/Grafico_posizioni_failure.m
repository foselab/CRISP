%% GRAFICO POSIZIONI FAILURE
%% ACC OTA 1
T1 = readtable('POSIZIONE FALLIMENTI ACC HECATE OTA 1.xlsx');
failure_vector_hecate = double(T1{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_hecate = categorical(T1{1:end,1});

T2 = readtable('POSIZIONE FALLIMENTI ACC APDISC OTA 1.xlsx');
failure_vector_apdisc= double(T2{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_apdisc = categorical(T2{1:end,1});



figure; 
plot(vettore_nomi_hecate,failure_vector_hecate,'bo','MarkerFaceColor', 'b');
hold on;
plot(vettore_nomi_apdisc,failure_vector_apdisc,'rs','MarkerFaceColor', 'r');
ylabel('Fault occurrence index');
legend('HECATE','APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\ANALISI FAILURE\analisi posizione fallimenti\ACC OTA 1','grafico_posizione_fallimenti_ACC_OTA_1.fig');
savefig(filename);

%% ACC OTA 2
T1 = readtable('POSIZIONE FALLIMENTI ACC HECATE OTA 2.xlsx');
failure_vector_hecate = double(T1{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_hecate = categorical(T1{1:end,1});

T2 = readtable('POSIZIONE FALLIMENTI ACC APDISC OTA 2.xlsx');
failure_vector_apdisc= double(T2{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_apdisc = categorical(T2{1:end,1});



figure; 
plot(vettore_nomi_hecate,failure_vector_hecate,'bo','MarkerFaceColor', 'b');
hold on;
plot(vettore_nomi_apdisc,failure_vector_apdisc,'rs','MarkerFaceColor', 'r');
ylabel('Fault occurrence index');
legend('HECATE','APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\ANALISI FAILURE\analisi posizione fallimenti\ACC OTA 2','grafico_posizione_fallimenti_ACC_OTA_2.fig');
savefig(filename);

%% LKA OTA 1
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 1.xlsx');
failure_vector_hecate = double(T1{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_hecate = categorical(T1{1:end,1});

T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 1.xlsx');
failure_vector_apdisc= double(T2{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_apdisc = categorical(T2{1:end,1});



figure; 
plot(vettore_nomi_hecate,failure_vector_hecate,'bo','MarkerFaceColor', 'b');
hold on;
plot(vettore_nomi_apdisc,failure_vector_apdisc,'rs','MarkerFaceColor', 'r');
ylabel('Fault occurrence index');
legend('HECATE','APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\ANALISI FAILURE\analisi posizione fallimenti\LKA OTA 1','grafico_posizione_fallimenti_LKA_OTA_1.fig');
savefig(filename);

%% LKA OTA 2
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 2.xlsx');
failure_vector_hecate = double(T1{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_hecate = categorical(T1{1:end,1});

T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 2.xlsx');
failure_vector_apdisc= double(T2{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_apdisc = categorical(T2{1:end,1});



figure; 
plot(vettore_nomi_hecate,failure_vector_hecate,'bo','MarkerFaceColor', 'b');
hold on;
plot(vettore_nomi_apdisc,failure_vector_apdisc,'rs','MarkerFaceColor', 'r');
ylabel('Fault occurrence index');
legend('HECATE','APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\ANALISI FAILURE\analisi posizione fallimenti\LKA OTA 2','grafico_posizione_fallimenti_LKA_OTA_2.fig');
savefig(filename);

%% LKA OTA 3
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 3.xlsx');
failure_vector_hecate = double(T1{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_hecate = categorical(T1{1:end,1});

T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 3.xlsx');
failure_vector_apdisc= double(T2{1:end, 2}); % Extract the collision column, excluding the header row
vettore_nomi_apdisc = categorical(T2{1:end,1});



figure; 
plot(vettore_nomi_hecate,failure_vector_hecate,'bo','MarkerFaceColor', 'b');
hold on;
plot(vettore_nomi_apdisc,failure_vector_apdisc,'rs','MarkerFaceColor', 'r');
ylabel('Fault occurrence index');
legend('HECATE','APDISC');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\ANALISI FAILURE\analisi posizione fallimenti\LKA OTA 3','grafico_posizione_fallimenti_LKA_OTA_3.fig');
savefig(filename);