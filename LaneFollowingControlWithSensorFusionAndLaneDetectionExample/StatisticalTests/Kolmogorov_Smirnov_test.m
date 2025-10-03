%% wilcoxon_rank_sum_test: it compare the behaviour of Hecate and Random approach


%% In each section, the reference table is taken and the fitness values are extracted. In this way, a vector is constructed containing, 
%% in sequence, the positions where the faults are found within the simulations
T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
vettore_fitness_RANDOM_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

position_vector_RANDOM_1 = [];

vettore_failure_binario_1 = zeros(1,length(vettore_fitness_RANDOM_1));
for i=1:length(vettore_fitness_RANDOM_1)
    if(vettore_fitness_RANDOM_1(i)<0)
        vettore_failure_binario_1(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_1)
    j=0;
    if(vettore_failure_binario_1(i)==1)
        position_vector_RANDOM_1 = [position_vector_RANDOM_1, i];
        j=j+1;
    end
end

%% table random 2

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
vettore_fitness_RANDOM_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

position_vector_RANDOM_2 = [];

vettore_failure_binario_2 = zeros(1,length(vettore_fitness_RANDOM_2));
for i=1:length(vettore_fitness_RANDOM_2)
    if(vettore_fitness_RANDOM_2(i)<0)
        vettore_failure_binario_2(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_2)
    j=0;
    if(vettore_failure_binario_2(i)==1)
        position_vector_RANDOM_2 = [position_vector_RANDOM_2, i];
        j=j+1;
    end
end 

%% table random 3

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
vettore_fitness_RANDOM_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

position_vector_RANDOM_3 = [];

vettore_failure_binario_3 = zeros(1,length(vettore_fitness_RANDOM_3));
for i=1:length(vettore_fitness_RANDOM_3)
    if(vettore_fitness_RANDOM_3(i)<0)
        vettore_failure_binario_3(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_3)
    j=0;
    if(vettore_failure_binario_3(i)==1)
        position_vector_RANDOM_3 = [position_vector_RANDOM_3, i];
        j=j+1;
    end
end

%% table random 4

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
vettore_fitness_RANDOM_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

position_vector_RANDOM_4 = [];

vettore_failure_binario_4 = zeros(1,length(vettore_fitness_RANDOM_4));
for i=1:length(vettore_fitness_RANDOM_4)
    if(vettore_fitness_RANDOM_4(i)<0)
        vettore_failure_binario_4(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_4)
    j=0;
    if(vettore_failure_binario_4(i)==1)
        position_vector_RANDOM_4 = [position_vector_RANDOM_4, i];
        j=j+1;
    end
end

%% table random 5

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
vettore_fitness_RANDOM_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

position_vector_RANDOM_5 = [];

vettore_failure_binario_5 = zeros(1,length(vettore_fitness_RANDOM_5));
for i=1:length(vettore_fitness_RANDOM_5)
    if(vettore_fitness_RANDOM_5(i)<0)
        vettore_failure_binario_5(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_5)
    j=0;
    if(vettore_failure_binario_5(i)==1)
        position_vector_RANDOM_5 = [position_vector_RANDOM_5, i];
        j=j+1;
    end
end

%% table FITNESS


T_fitness = readtable('tabellarisultatiHecate_CONF1_finale.xlsx');
vettore_fitness_HECATE = double(T_fitness{1:end, 3});

position_vector_HECATE = [];

vettore_failure_binario_HECATE = zeros(1,length(vettore_fitness_HECATE));
for i=1:length(vettore_fitness_HECATE)
    if(vettore_fitness_HECATE(i)<0)
        vettore_failure_binario_HECATE(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_HECATE)
    j=0;
    if(vettore_failure_binario_HECATE(i)==1)
        position_vector_HECATE = [position_vector_HECATE, i];
        j=j+1;
    end
end

%% statistical test: Kolmogorov-Smirnov (test statistico eseguito per paragonare il comportamento dell'algoritmo scelto con il comportamento ottimale)

position_vector_RANDOM_TOTAL = [position_vector_RANDOM_1 position_vector_RANDOM_2 position_vector_RANDOM_3 position_vector_RANDOM_4 position_vector_RANDOM_5];

Nfault = length(position_vector_HECATE);
NTotal = length(vettore_fitness_HECATE);

x_ottimale = [1:Nfault, NTotal]';
F_ottimale = [(1:Nfault)/Nfault, 1]';

CDF_ottimale = [x_ottimale, F_ottimale];

[h, p, ksstat] = kstest(x_algoritmo, 'CDF', CDF_ottimale)

figure;
[F_alg, x_ecdf] = ecdf(x_algoritmo); % Calcola la CDF empirica del tuo algoritmo
stairs(x_ecdf, F_alg, 'b', 'LineWidth', 2);
hold on;
stairs(CDF_ottimale(:,1), CDF_ottimale(:,2), 'r--', 'LineWidth', 2);
title('Confronto CDF: Algoritmo (Empirica) vs. Ottimale (Teorica)');
xlabel('Numero di Simulazione');
ylabel('Proporzione Cumulativa di Fault Trovati');
legend('Algoritmo (F_{alg})', 'Ottimale (F_{ott})', 'Location', 'southeast');
grid on;


%% statistical test: Kolmogorov-Smirnov (eseguito tra le performance di Hecate e gli altri approcci)

x_algoritmo = position_vector_HECATE';
x_random = position_vector_RANDOM_1';

[h, p, ks2stat] = kstest2(x_algoritmo, x_random)

figure;
hold on;
grid on;

% 1. Calcola e traccia la CDF del tuo Algoritmo
[F_alg, x_alg] = ecdf(x_algoritmo);
stairs(x_alg, F_alg, 'b', 'LineWidth', 2); % 'stairs' per una CDF a gradini

% 2. Calcola e traccia la CDF del Campione Casuale
[F_rand, x_rand] = ecdf(x_random);
stairs(x_rand, F_rand, 'r--', 'LineWidth', 2); 

% 3. Aggiungi Titoli e Legenda
title('Confronto tra le CDF: Algoritmo vs. Casuale');
xlabel('Numero di Simulazione');
ylabel('Proporzione Cumulativa di Fault Trovati');
legend('Algoritmo (Tuoi Dati)', 'Casuale (Campione Simulato)', 'Location', 'southeast');

hold off;






