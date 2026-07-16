%% ANALISI COMPLESSIVA COMPORTAMENTO HECATE VS APDISC
%% GRAFICO POSIZIONI FAILURE
%% ACC OTA 1
T1 = readtable('POSIZIONE FALLIMENTI ACC HECATE OTA 1.xlsx');
failure_vector_hecate_ACC_OTA_1 = double(T1{1:end, 2}); % Extract the collision column, excluding the header row


T2 = readtable('POSIZIONE FALLIMENTI ACC APDISC OTA 1.xlsx');
failure_vector_apdisc_ACC_OTA_1= double(T2{1:end, 2}); % Extract the collision column, excluding the header row

%% ACC OTA 2
T1 = readtable('POSIZIONE FALLIMENTI ACC HECATE OTA 2.xlsx');
failure_vector_hecate_ACC_OTA_2 = double(T1{1:end, 2}); % Extract the collision column, excluding the header row


T2 = readtable('POSIZIONE FALLIMENTI ACC APDISC OTA 2.xlsx');
failure_vector_apdisc_ACC_OTA_2= double(T2{1:end, 2}); % Extract the collision column, excluding the header row

%% LKA OTA 1
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 1.xlsx');
failure_vector_hecate_LKA_OTA_1 = double(T1{1:end, 2}); % Extract the collision column, excluding the header row


T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 1.xlsx');
failure_vector_apdisc_LKA_OTA_1= double(T2{1:end, 2}); % Extract the collision column, excluding the header row


%% LKA OTA 2
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 2.xlsx');
failure_vector_hecate_LKA_OTA_2 = double(T1{1:end, 2}); % Extract the collision column, excluding the header row


T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 2.xlsx');
failure_vector_apdisc_LKA_OTA_2= double(T2{1:end, 2}); % Extract the collision column, excluding the header row



%% LKA OTA 3
T1 = readtable('POSIZIONE FALLIMENTI LKA HECATE OTA 3.xlsx');
failure_vector_hecate_LKA_OTA_3 = double(T1{1:end, 2}); % Extract the collision column, excluding the header row


T2 = readtable('POSIZIONE FALLIMENTI LKA APDISC OTA 3.xlsx');
failure_vector_apdisc_LKA_OTA_3= double(T2{1:end, 2}); % Extract the collision column, excluding the header row

%% VETTORE COMPLETO
failure_vector_hecate =[failure_vector_hecate_ACC_OTA_1' failure_vector_hecate_ACC_OTA_2' failure_vector_hecate_LKA_OTA_1' failure_vector_hecate_LKA_OTA_2' failure_vector_hecate_LKA_OTA_3'];
failure_vector_apdisc =[failure_vector_apdisc_ACC_OTA_1' failure_vector_apdisc_ACC_OTA_2' failure_vector_apdisc_LKA_OTA_1' failure_vector_apdisc_LKA_OTA_2' failure_vector_apdisc_LKA_OTA_3'];

min_hecate = min(failure_vector_hecate);
max_hecate = max(failure_vector_hecate);
std_hecate = std(failure_vector_hecate);

min_APDISC = min(failure_vector_apdisc);
max_APDISC = max(failure_vector_apdisc);
std_APDISC = std(failure_vector_apdisc);

failure_vector_random = readmatrix('vettore_medio_random_complessivo.xlsx');

min_RANDOM = min(failure_vector_random);
max_RANDOM = max(failure_vector_random);
std_RANDOM = std(failure_vector_random);

%% BOX PLOT
MATRICE = [failure_vector_hecate',failure_vector_apdisc',failure_vector_random'];
boxplot(MATRICE,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(MATRICE, 'omitnan');
positions = 1:size(MATRICE,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
xlabel('Prioritization Algorithm')
ylabel('Failure index')

saveas(gcf,'boxplot_GENERALE.fig');
%% ANALISI STATISTICA A12
gruppoA = failure_vector_hecate;
gruppoB = failure_vector_apdisc;

% 1. Assicurati che i dati siano vettori colonna (buona prassi)
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% 2. Calcola le dimensioni dei campioni
m = length(gruppoA);
n = length(gruppoB);

% 3. Esegui il test ranksum per ottenere la somma dei ranghi del gruppoA
% L'ordine è importante: ranksum(A, B)
[p, h, stats] = ranksum(gruppoA, gruppoB);

% 4. Prendi la somma dei ranghi per il gruppo A (stats.ranksum)
R_A = stats.ranksum;

% 5. Calcola la statistica U per il gruppo A
U_A = R_A - (m * (m + 1) / 2);

% 6. Calcola l'effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% Mostra il risultato
fprintf('La statistica 1-A12 (probabilità che A < B) è: %.4f\n', A12_CORRETTO);

%% ANALISI STATISTICA K-S
x_HECATE = failure_vector_hecate;
x_APDISC = failure_vector_apdisc;

[h1, p1, ks2stat1] = kstest2(x_HECATE, x_APDISC)

%[p,h,stats]=ranksum(failure_vector_hecate,failure_vector_apdisc)