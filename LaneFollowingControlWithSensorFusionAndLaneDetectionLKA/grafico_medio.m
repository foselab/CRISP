%% CREAZIONE GRAFICO MEDIO 
T1 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_1.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

T2 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_2.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

T3 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_3.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

T4 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_4.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

T5 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_5.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);




%% calcolo vettore medio
vettore_failure_medio = zeros(1,length(binary_failure_vector_1));


for j=1:length(binary_failure_vector_1)
    sum = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = sum/5; 
    vettore_failure_medio(j)=valore_medio; 
end

%% disegno grafico 
asse_x = 1:length(vettore_failure_medio); 

figure; 
p=plot(asse_x,vettore_failure_medio);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(vettore_failure_medio));

xlabel('Simulazioni');
ylabel('Failure');
title('Grafico performance RANDOM MEDIO');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\LaneFollowingControlWithSensorFusionAndLaneDetectionLKA\grafici\OTA3','grafico_random_medio_CONF3.fig');
savefig(filename);

%% grafico sovrapposto 
T_fitness = readtable('tabellarisultati_LKA_CONF3_HECATE.xlsx');
vettore_failure = double(T_fitness{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

T = readtable('tabellarisultati_LKA_CONF3_APDISC.xlsx');
vettore_failure_APDISC = double(T{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_APDISC = zeros(1,length(vettore_failure_APDISC));
for i=1:length(vettore_failure_APDISC)
    if(vettore_failure_APDISC(i)<0)
        binary_failure_vector_APDISC(i)=1;
    end
end

binary_failure_vector_APDISC = cumsum(binary_failure_vector_APDISC);

asse_x = 1:length(vettore_failure);
figure; 
p=plot(asse_x, binary_failure_vector,'g-o', asse_x, vettore_failure_medio,'r--s', asse_x,binary_failure_vector_APDISC,'b:d');
p(1).LineWidth=2;
p(2).LineWidth=2;
p(3).LineWidth=2;


yticks(0:1:max(vettore_failure_medio));

xlabel('Simulation index');
ylabel('Cumulative faults');
title(' FITNESS(green) vs RANDOM(red) vs APDISC(blue)');
grid on;
legend({'FITNESS','RANDOM','APDISC'}, 'Location', 'northwest');
filename = fullfile('C:\Users\Luca\Desktop\LaneFollowingControlWithSensorFusionAndLaneDetectionLKA\grafici\OTA3','grafico_CONFRONTO_CONF3.fig');
savefig(filename);
