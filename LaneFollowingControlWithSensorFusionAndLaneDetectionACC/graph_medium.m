%% MEDIUM GRAPH CREATION
T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
failure_vector_1 = double(T1{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_1 = zeros(1,length(failure_vector_1));
for i=1:length(failure_vector_1)
    if(failure_vector_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
failure_vector_2 = double(T2{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_2 = zeros(1,length(failure_vector_2));
for i=1:length(failure_vector_2)
    if(failure_vector_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
failure_vector_3 = double(T3{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_3 = zeros(1,length(failure_vector_3));
for i=1:length(failure_vector_3)
    if(failure_vector_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
failure_vector_4 = double(T4{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_4 = zeros(1,length(failure_vector_4));
for i=1:length(failure_vector_4)
    if(failure_vector_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
failure_vector_5 = double(T5{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_5 = zeros(1,length(failure_vector_5));
for i=1:length(failure_vector_5)
    if(failure_vector_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);




%% average vector calculation
failure_vector_medio = zeros(1,length(binary_failure_vector_1));


for j=1:length(binary_failure_vector_1)
    sum = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = sum/5; 
    failure_vector_medio(j)=valore_medio; 
end

%% GRAPH 
x_axis = 1:length(failure_vector_medio); 

figure; 
p=plot(x_axis,failure_vector_medio);
p.LineWidth=2;
p.Marker="o";

yticks(0:1:max(failure_vector_medio));

xlabel('Simulations');
ylabel('Failure');
title('RANDOM Avg. Performance');
grid on;
filepath = fileparts(mfilename('fullpath'));
filename = fullfile(filepath, '\plots\OTA1','grafico_random_medio_CONF1.fig');
savefig(filename);

%% overlay graph 
T_fitness = readtable('tabellarisultatiHecate_CONF1_finale.xlsx');
failure_vector = double(T_fitness{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_FITNESS = zeros(1,length(failure_vector));
for i=1:length(failure_vector)
    if(failure_vector(i)<0)
        binary_failure_vector_FITNESS(i)=1;
    end
end

binary_failure_vector_FITNESS = cumsum(binary_failure_vector_FITNESS);

T_APDISC = readtable('tabellarisultatiHecate_CONF1_APDISC.xlsx');
failure_vector = double(T_APDISC{1:end, 3}); % extract the collisions column excluding the first header row
binary_failure_vector_APDISC = zeros(1,length(failure_vector));
for i=1:length(failure_vector)
    if(failure_vector(i)<0)
        binary_failure_vector_APDISC(i)=1;
    end
end

binary_failure_vector_APDISC = cumsum(binary_failure_vector_APDISC);


x_axis = 1:length(failure_vector);
figure; 
p=plot(x_axis, binary_failure_vector_FITNESS,'g-o', x_axis, failure_vector_medio,'r--s',x_axis, binary_failure_vector_APDISC,'b:d');
p(1).LineWidth=2;
p(2).LineWidth=2;
p(3).LineWidth=2;


yticks(0:1:max(failure_vector_medio));

xlabel('Simulation index');
ylabel('Cumulative faults');
title('FITNESS (green) vs RANDOM (red) vs APDISC (blue)');
grid on;
filepath = fileparts(mfilename('fullpath'));
filename = fullfile(filepath, '\plots\OTA1','grafico_CONFRONTO_CONF1.fig');
savefig(filename);
