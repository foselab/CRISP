%% CREAZIONE GRAFICO MEDIO 
T1 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_1.xlsx');
failure_vector_1 = double(T1{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_1 = zeros(1,length(failure_vector_1));
for i=1:length(failure_vector_1)
    if(failure_vector_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

T2 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_2.xlsx');
failure_vector_2 = double(T2{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_2 = zeros(1,length(failure_vector_2));
for i=1:length(failure_vector_2)
    if(failure_vector_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

T3 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_3.xlsx');
failure_vector_3 = double(T3{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_3 = zeros(1,length(failure_vector_3));
for i=1:length(failure_vector_3)
    if(failure_vector_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

T4 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_4.xlsx');
failure_vector_4 = double(T4{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_4 = zeros(1,length(failure_vector_4));
for i=1:length(failure_vector_4)
    if(failure_vector_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

T5 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_5.xlsx');
failure_vector_5 = double(T5{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_5 = zeros(1,length(failure_vector_5));
for i=1:length(failure_vector_5)
    if(failure_vector_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);




%% calcolo vettore medio
failure_vector_medio = zeros(1,length(binary_failure_vector_1));


for j=1:length(binary_failure_vector_1)
    sum = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = sum/5; 
    failure_vector_medio(j)=valore_medio; 
end

%% disegno grafico 
x_axis = 1:length(failure_vector_medio); 

figure; 
p=plot(x_axis,failure_vector_medio);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(failure_vector_medio));

xlabel('Simulations');
ylabel('Failure');
title('Grafico performance RANDOM MEDIO');
grid on;
filename = fullfile('C:\Users\Luca\Desktop\LaneFollowingControlWithSensorFusionAndLaneDetectionLKA\grafici\OTA3','grafico_random_medio_CONF3.fig');
savefig(filename);

%% grafico sovrapposto 
T_fitness = readtable('tabellarisultati_LKA_CONF3_HECATE.xlsx');
failure_vector = double(T_fitness{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector = zeros(1,length(failure_vector));
for i=1:length(failure_vector)
    if(failure_vector(i)<0)
        binary_failure_vector(i)=1;
    end
end

binary_failure_vector = cumsum(binary_failure_vector);

T = readtable('tabellarisultati_LKA_CONF3_APDISC.xlsx');
failure_vector_APDISC = double(T{1:end, 3}); % Extract the collision column, excluding the header row
binary_failure_vector_APDISC = zeros(1,length(failure_vector_APDISC));
for i=1:length(failure_vector_APDISC)
    if(failure_vector_APDISC(i)<0)
        binary_failure_vector_APDISC(i)=1;
    end
end

binary_failure_vector_APDISC = cumsum(binary_failure_vector_APDISC);

x_axis = 1:length(failure_vector);
figure; 
p=plot(x_axis, binary_failure_vector,'g-o', x_axis, failure_vector_medio,'r--s', x_axis,binary_failure_vector_APDISC,'b:d');
p(1).LineWidth=2;
p(2).LineWidth=2;
p(3).LineWidth=2;


yticks(0:1:max(failure_vector_medio));

xlabel('Simulation index');
ylabel('Cumulative faults');
title(' FITNESS(green) vs RANDOM(red) vs APDISC(blue)');
grid on;
legend({'FITNESS','RANDOM','APDISC'}, 'Location', 'northwest');
filename = fullfile('C:\Users\Luca\Desktop\LaneFollowingControlWithSensorFusionAndLaneDetectionLKA\grafici\OTA3','grafico_CONFRONTO_CONF3.fig');
savefig(filename);
