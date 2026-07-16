%% wilcoxon_rank_sum_test: it compare the behaviour of Hecate and Random approach


%% In each section, the reference table is taken and the fitness values are extracted. In this way, a vector is constructed containing, 
%% in sequence, the positions where the faults are found within the simulations
T1 = readtable('tabellarisultati_RANDOM1_CONF_2.xlsx');
vettore_fitness_RANDOM_1 = double(T1{1:end, 3}); % Extract the collision column, excluding the header row

position_vector_RANDOM_1 = [];

binary_failure_vector_1 = zeros(1,length(vettore_fitness_RANDOM_1));
for i=1:length(vettore_fitness_RANDOM_1)
    if(vettore_fitness_RANDOM_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1 = [position_vector_RANDOM_1, i];
        j=j+1;
    end
end

%% table random 2

T2 = readtable('tabellarisultati_RANDOM2_CONF_2.xlsx');
vettore_fitness_RANDOM_2 = double(T2{1:end, 3}); % Extract the collision column, excluding the header row

position_vector_RANDOM_2 = [];

binary_failure_vector_2 = zeros(1,length(vettore_fitness_RANDOM_2));
for i=1:length(vettore_fitness_RANDOM_2)
    if(vettore_fitness_RANDOM_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2 = [position_vector_RANDOM_2, i];
        j=j+1;
    end
end 

%% table random 3

T3 = readtable('tabellarisultati_RANDOM3_CONF_2.xlsx');
vettore_fitness_RANDOM_3 = double(T3{1:end, 3}); % Extract the collision column, excluding the header row

position_vector_RANDOM_3 = [];

binary_failure_vector_3 = zeros(1,length(vettore_fitness_RANDOM_3));
for i=1:length(vettore_fitness_RANDOM_3)
    if(vettore_fitness_RANDOM_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3 = [position_vector_RANDOM_3, i];
        j=j+1;
    end
end

%% table random 4

T4 = readtable('tabellarisultati_RANDOM4_CONF_2.xlsx');
vettore_fitness_RANDOM_4 = double(T4{1:end, 3}); % Extract the collision column, excluding the header row

position_vector_RANDOM_4 = [];

binary_failure_vector_4 = zeros(1,length(vettore_fitness_RANDOM_4));
for i=1:length(vettore_fitness_RANDOM_4)
    if(vettore_fitness_RANDOM_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4 = [position_vector_RANDOM_4, i];
        j=j+1;
    end
end

%% table random 5

T5 = readtable('tabellarisultati_RANDOM5_CONF_2.xlsx');
vettore_fitness_RANDOM_5 = double(T5{1:end, 3}); % Extract the collision column, excluding the header row

position_vector_RANDOM_5 = [];

binary_failure_vector_5 = zeros(1,length(vettore_fitness_RANDOM_5));
for i=1:length(vettore_fitness_RANDOM_5)
    if(vettore_fitness_RANDOM_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5 = [position_vector_RANDOM_5, i];
        j=j+1;
    end
end

%% table FITNESS


T_fitness = readtable('tabellarisultati_HECATE_CONF_2.xlsx');
vettore_fitness_HECATE = double(T_fitness{1:end, 3});

position_vector_HECATE = [];

binary_failure_vector_HECATE = zeros(1,length(vettore_fitness_HECATE));
for i=1:length(vettore_fitness_HECATE)
    if(vettore_fitness_HECATE(i)<0)
        binary_failure_vector_HECATE(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE)
    j=0;
    if(binary_failure_vector_HECATE(i)==1)
        position_vector_HECATE = [position_vector_HECATE, i];
        j=j+1;
    end
end

%% table APDISC
T_fitness = readtable('tabellarisultati_APDISC_CONF2.xlsx');
vettore_fitness_APDISC = double(T_fitness{1:end, 3});

position_vector_APDISC = [];

binary_failure_vector_APDISC = zeros(1,length(vettore_fitness_APDISC));
for i=1:length(vettore_fitness_APDISC)
    if(vettore_fitness_APDISC(i)<0)
        binary_failure_vector_APDISC(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC)
    j=0;
    if(binary_failure_vector_APDISC(i)==1)
        position_vector_APDISC = [position_vector_APDISC, i];
        j=j+1;
    end
end


%% statistical test: Kolmogorov-Smirnov (eseguito tra le performance di Hecate e gli altri approcci)

position_vector_RANDOM_TOTAL = [position_vector_RANDOM_1 position_vector_RANDOM_2 position_vector_RANDOM_3 position_vector_RANDOM_4 position_vector_RANDOM_5];

x_algoritmo = position_vector_APDISC';
x_random = position_vector_RANDOM_TOTAL';

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






