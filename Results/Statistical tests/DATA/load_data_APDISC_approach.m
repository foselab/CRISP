%% DATA APDISC APPROACH
%% ACC: table APDISC OTA 1
T_fitness = readtable('tabellarisultati_APDISC_CONF1.xlsx');
vettore_fitness_APDISC_ACC_OTA_1 = double(T_fitness{1:end, 3});

position_vector_APDISC_ACC_OTA_1 = [];

binary_failure_vector_APDISC_ACC_OTA_1 = zeros(1,length(vettore_fitness_APDISC_ACC_OTA_1));
for i=1:length(vettore_fitness_APDISC_ACC_OTA_1)
    if(vettore_fitness_APDISC_ACC_OTA_1(i)<0)
        binary_failure_vector_APDISC_ACC_OTA_1(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC_ACC_OTA_1)
    j=0;
    if(binary_failure_vector_APDISC_ACC_OTA_1(i)==1)
        position_vector_APDISC_ACC_OTA_1 = [position_vector_APDISC_ACC_OTA_1, i];
        j=j+1;
    end
end

%% ACC: table APDISC OTA 2
T_fitness = readtable('tabellarisultati_APDISC_CONF2.xlsx');
vettore_fitness_APDISC_ACC_OTA_2 = double(T_fitness{1:end, 3});

position_vector_APDISC_ACC_OTA_2 = [];

binary_failure_vector_APDISC_ACC_OTA_2 = zeros(1,length(vettore_fitness_APDISC_ACC_OTA_2));
for i=1:length(vettore_fitness_APDISC_ACC_OTA_2)
    if(vettore_fitness_APDISC_ACC_OTA_2(i)<0)
        binary_failure_vector_APDISC_ACC_OTA_2(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC_ACC_OTA_2)
    j=0;
    if(binary_failure_vector_APDISC_ACC_OTA_2(i)==1)
        position_vector_APDISC_ACC_OTA_2 = [position_vector_APDISC_ACC_OTA_2, i];
        j=j+1;
    end
end


%% LKA: table APDISC OTA 1
T_fitness = readtable('tabellarisultati_LKA_CONF1_APDISC.xlsx');
vettore_fitness_APDISC_LKA_OTA_1 = double(T_fitness{1:end, 3});

position_vector_APDISC_LKA_OTA_1 = [];

binary_failure_vector_APDISC_LKA_OTA_1 = zeros(1,length(vettore_fitness_APDISC_LKA_OTA_1));
for i=1:length(vettore_fitness_APDISC_LKA_OTA_1)
    if(vettore_fitness_APDISC_LKA_OTA_1(i)<0)
        binary_failure_vector_APDISC_LKA_OTA_1(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC_LKA_OTA_1)
    j=0;
    if(binary_failure_vector_APDISC_LKA_OTA_1(i)==1)
        position_vector_APDISC_LKA_OTA_1 = [position_vector_APDISC_LKA_OTA_1, i];
        j=j+1;
    end
end

%% LKA: table APDISC OTA 2
T_fitness = readtable('tabellarisultati_LKA_CONF2_APDISC.xlsx');
vettore_fitness_APDISC_LKA_OTA_2 = double(T_fitness{1:end, 3});

position_vector_APDISC_LKA_OTA_2 = [];

binary_failure_vector_APDISC_LKA_OTA_2 = zeros(1,length(vettore_fitness_APDISC_LKA_OTA_2));
for i=1:length(vettore_fitness_APDISC_LKA_OTA_2)
    if(vettore_fitness_APDISC_LKA_OTA_2(i)<0)
        binary_failure_vector_APDISC_LKA_OTA_2(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC_LKA_OTA_2)
    j=0;
    if(binary_failure_vector_APDISC_LKA_OTA_2(i)==1)
        position_vector_APDISC_LKA_OTA_2 = [position_vector_APDISC_LKA_OTA_2, i];
        j=j+1;
    end
end

%% LKA: table APDISC OTA 3
T_fitness = readtable('tabellarisultati_LKA_CONF3_APDISC.xlsx');
vettore_fitness_APDISC_LKA_OTA_3 = double(T_fitness{1:end, 3});

position_vector_APDISC_LKA_OTA_3 = [];

binary_failure_vector_APDISC_LKA_OTA_3 = zeros(1,length(vettore_fitness_APDISC_LKA_OTA_3));
for i=1:length(vettore_fitness_APDISC_LKA_OTA_3)
    if(vettore_fitness_APDISC_LKA_OTA_3(i)<0)
        binary_failure_vector_APDISC_LKA_OTA_3(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_APDISC_LKA_OTA_3)
    j=0;
    if(binary_failure_vector_APDISC_LKA_OTA_3(i)==1)
        position_vector_APDISC_LKA_OTA_3 = [position_vector_APDISC_LKA_OTA_3, i];
        j=j+1;
    end
end
