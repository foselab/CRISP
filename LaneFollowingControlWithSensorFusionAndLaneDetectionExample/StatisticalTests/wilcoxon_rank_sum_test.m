%% wilcoxon_rank_sum_test: it compare the behaviour of Hecate and Random approach

T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
vettore_fitness_RANDOM_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
vettore_fitness_RANDOM_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
vettore_fitness_RANDOM_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
vettore_fitness_RANDOM_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
vettore_fitness_RANDOM_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione

matrix_vector = [vettore_fitness_RANDOM_1 vettore_fitness_RANDOM_2 vettore_fitness_RANDOM_3 vettore_fitness_RANDOM_4 vettore_fitness_RANDOM_5];

vettore_medio_RANDOM = mean(matrix_vector, 2);


T_fitness = readtable('tabellarisultatiHecate_CONF1_finale.xlsx');
vettore_fitness_HECATE = double(T_fitness{1:end, 3});

[p,h,stats] = ranksum(vettore_fitness_HECATE,vettore_medio_RANDOM)


