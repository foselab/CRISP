%% CREAZIONE GRAFICO MEDIO 
T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_1 = zeros(1,length(vettore_failure_1));
for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        vettore_failure_binario_1(i)=1;
    end
end

vettore_failure_binario_1 = cumsum(vettore_failure_binario_1);

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_2 = zeros(1,length(vettore_failure_2));
for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        vettore_failure_binario_2(i)=1;
    end
end

vettore_failure_binario_2 = cumsum(vettore_failure_binario_2);

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_3 = zeros(1,length(vettore_failure_3));
for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        vettore_failure_binario_3(i)=1;
    end
end

vettore_failure_binario_3 = cumsum(vettore_failure_binario_3);

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_4 = zeros(1,length(vettore_failure_4));
for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        vettore_failure_binario_4(i)=1;
    end
end

vettore_failure_binario_4 = cumsum(vettore_failure_binario_4);

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_5 = zeros(1,length(vettore_failure_5));
for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        vettore_failure_binario_5(i)=1;
    end
end

vettore_failure_binario_5 = cumsum(vettore_failure_binario_5);




%% calcolo vettore medio
vettore_failure_medio = zeros(1,length(vettore_failure_binario_1));


for j=1:length(vettore_failure_binario_1)
    sum = vettore_failure_binario_1(j)+vettore_failure_binario_2(j)+vettore_failure_binario_3(j)+vettore_failure_binario_4(j)+vettore_failure_binario_5(j);
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
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici\OTA1','grafico_random_medio_CONF1.fig');
savefig(filename);

%% grafico sovrapposto 
T_fitness = readtable('tabellarisultatiHecate_CONF1_finale.xlsx');
vettore_failure = double(T_fitness{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_FITNESS = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario_FITNESS(i)=1;
    end
end

vettore_failure_binario_FITNESS = cumsum(vettore_failure_binario_FITNESS);

T_APDISC = readtable('tabellarisultatiHecate_CONF1_APDISC.xlsx');
vettore_failure = double(T_APDISC{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_failure_binario_APDISC = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        vettore_failure_binario_APDISC(i)=1;
    end
end

vettore_failure_binario_APDISC = cumsum(vettore_failure_binario_APDISC);


asse_x = 1:length(vettore_failure);
figure; 
p=plot(asse_x, vettore_failure_binario_FITNESS,'g-o', asse_x, vettore_failure_medio,'r-o',asse_x, vettore_failure_binario_APDISC,'b-o');
p(1).LineWidth=2;
p(2).LineWidth=2;
p(3).LineWidth=2;


yticks(0:1:max(vettore_failure_medio));

xlabel('Simulazioni');
ylabel('Failure');
title('FITNESS (green) vs RANDOM (red) vs APDISC (blue)');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionExample\grafici\OTA1','grafico_CONFRONTO_CONF1.fig');
savefig(filename);
