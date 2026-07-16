%% MEDIUM GRAPH CREATION
T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);




%% average vector calculation
vettore_failure_medio = zeros(1,length(binary_failure_vector_1));


for j=1:length(binary_failure_vector_1)
    sum = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = sum/5; 
    vettore_failure_medio(j)=valore_medio; 
end

%% GRAPH 
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
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA1','grafico_random_medio_CONF1.fig');
savefig(filename);

%% overlay graph 
T_fitness = readtable('tabellarisultatiHecate_CONF1_finale.xlsx');
vettore_failure = double(T_fitness{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_FITNESS = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector_FITNESS(i)=1;
    end
end

binary_failure_vector_FITNESS = cumsum(binary_failure_vector_FITNESS);

T_APDISC = readtable('tabellarisultatiHecate_CONF1_APDISC.xlsx');
vettore_failure = double(T_APDISC{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_APDISC = zeros(1,length(vettore_failure));
for i=1:length(vettore_failure)
    if(vettore_failure(i)<0)
        binary_failure_vector_APDISC(i)=1;
    end
end

binary_failure_vector_APDISC = cumsum(binary_failure_vector_APDISC);


asse_x = 1:length(vettore_failure);
figure; 
p=plot(asse_x, binary_failure_vector_FITNESS,'g-o', asse_x, vettore_failure_medio,'r--s',asse_x, binary_failure_vector_APDISC,'b:d');
p(1).LineWidth=2;
p(2).LineWidth=2;
p(3).LineWidth=2;


yticks(0:1:max(vettore_failure_medio));

xlabel('Simulation index');
ylabel('Cumulative faults');
title('FITNESS (green) vs RANDOM (red) vs APDISC (blue)');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\tesi ACC\carminati\LaneFollowingControlWithSensorFusionAndLaneDetectionACC\grafici\OTA1','grafico_CONFRONTO_CONF1.fig');
savefig(filename);
