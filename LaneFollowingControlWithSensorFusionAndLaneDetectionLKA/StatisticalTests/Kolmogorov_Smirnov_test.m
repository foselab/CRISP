%% wilcoxon_rank_sum_test: it compare the behaviour of Hecate and Random approach


%% In each section, the reference table is taken and the fitness values are extracted. In this way, a vector is constructed containing, 
%% in sequence, the positions where the faults are found within the simulations
T1 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_1.xlsx');
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

T2 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_2.xlsx');
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

T3 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_3.xlsx');
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

T4 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_4.xlsx');
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

T5 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_5.xlsx');
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


T_fitness = readtable('tabellarisultati_LKA_CONF_2_HECATE.xlsx');
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

%% table APDISC
T_fitness = readtable('tabellarisultati_LKA_CONF2_APDISC.xlsx');
vettore_fitness_APDISC = double(T_fitness{1:end, 3});

position_vector_APDISC = [];

vettore_failure_binario_APDISC = zeros(1,length(vettore_fitness_APDISC));
for i=1:length(vettore_fitness_APDISC)
    if(vettore_fitness_APDISC(i)<0)
        vettore_failure_binario_APDISC(i)=1;
    end
end

for i = 1 : length(vettore_failure_binario_APDISC)
    j=0;
    if(vettore_failure_binario_APDISC(i)==1)
        position_vector_APDISC = [position_vector_APDISC, i];
        j=j+1;
    end
end


%% statistical test: Kolmogorov-Smirnov (eseguito tra le performance di Hecate e gli altri approcci)

position_vector_RANDOM_TOTAL = [position_vector_RANDOM_1 position_vector_RANDOM_2 position_vector_RANDOM_3 position_vector_RANDOM_4 position_vector_RANDOM_5];

x_algoritmo = position_vector_HECATE';
x_random = position_vector_APDISC';

[h, p, ks2stat] = kstest2(x_algoritmo, x_random)







