%% DATA HECATE APPROACH

%% ACC: table HECATE OTA1


T_fitness = readtable('tabellarisultati_HECATE_CONF1.xlsx');
vettore_fitness_HECATE_ACC_OTA_1 = double(T_fitness{1:end, 3});

position_vector_HECATE_ACC_OTA_1 = [];

binary_failure_vector_HECATE__ACC_OTA_1 = zeros(1,length(vettore_fitness_HECATE_ACC_OTA_1));
for i=1:length(vettore_fitness_HECATE_ACC_OTA_1)
    if(vettore_fitness_HECATE_ACC_OTA_1(i)<0)
        binary_failure_vector_HECATE__ACC_OTA_1(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE__ACC_OTA_1)
    j=0;
    
    if(binary_failure_vector_HECATE__ACC_OTA_1(i)==1)
        position_vector_HECATE_ACC_OTA_1 = [position_vector_HECATE_ACC_OTA_1, i];
        j=j+1;
    end
end


%% ACC: table HECATE OTA2


T_fitness = readtable('tabellarisultati_HECATE_CONF_2.xlsx');
vettore_fitness_HECATE_ACC_OTA_2 = double(T_fitness{1:end, 3});

position_vector_HECATE_ACC_OTA_2 = [];

binary_failure_vector_HECATE__ACC_OTA_2 = zeros(1,length(vettore_fitness_HECATE_ACC_OTA_2));
for i=1:length(vettore_fitness_HECATE_ACC_OTA_2)
    if(vettore_fitness_HECATE_ACC_OTA_2(i)<0)
        binary_failure_vector_HECATE__ACC_OTA_2(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE__ACC_OTA_2)
    j=0;
    if(binary_failure_vector_HECATE__ACC_OTA_2(i)==1)
        position_vector_HECATE_ACC_OTA_2 = [position_vector_HECATE_ACC_OTA_2, i];
        j=j+1;
    end
end











%% LKA: table HECATE OTA1


T_fitness = readtable('tabellarisultati_LKA_CONF1_HECATE.xlsx');
vettore_fitness_HECATE_LKA_OTA_1 = double(T_fitness{1:end, 3});

position_vector_HECATE_LKA_OTA_1 = [];

binary_failure_vector_HECATE_LKA_OTA_1 = zeros(1,length(vettore_fitness_HECATE_LKA_OTA_1));
for i=1:length(vettore_fitness_HECATE_LKA_OTA_1)
    if(vettore_fitness_HECATE_LKA_OTA_1(i)<0)
        binary_failure_vector_HECATE_LKA_OTA_1(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE_LKA_OTA_1)
    j=0;
    if(binary_failure_vector_HECATE_LKA_OTA_1(i)==1)
        position_vector_HECATE_LKA_OTA_1 = [position_vector_HECATE_LKA_OTA_1, i];
        j=j+1;
    end
end

%% LKA: table HECATE OTA2


T_fitness = readtable('tabellarisultati_LKA_CONF_2_HECATE.xlsx');
vettore_fitness_HECATE_LKA_OTA_2 = double(T_fitness{1:end, 3});

position_vector_HECATE_LKA_OTA_2 = [];

binary_failure_vector_HECATE_LKA_OTA_2 = zeros(1,length(vettore_fitness_HECATE_LKA_OTA_2));
for i=1:length(vettore_fitness_HECATE_LKA_OTA_2)
    if(vettore_fitness_HECATE_LKA_OTA_2(i)<0)
        binary_failure_vector_HECATE_LKA_OTA_2(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE_LKA_OTA_2)
    j=0;
    if(binary_failure_vector_HECATE_LKA_OTA_2(i)==1)
        position_vector_HECATE_LKA_OTA_2 = [position_vector_HECATE_LKA_OTA_2, i];
        j=j+1;
    end
end

%% LKA: table HECATE OTA3


T_fitness = readtable('tabellarisultati_LKA_CONF3_HECATE.xlsx');
vettore_fitness_HECATE_LKA_OTA_3 = double(T_fitness{1:end, 3});

position_vector_HECATE_LKA_OTA_3 = [];

binary_failure_vector_HECATE_LKA_OTA_3 = zeros(1,length(vettore_fitness_HECATE_LKA_OTA_3));
for i=1:length(vettore_fitness_HECATE_LKA_OTA_3)
    if(vettore_fitness_HECATE_LKA_OTA_3(i)<0)
        binary_failure_vector_HECATE_LKA_OTA_3(i)=1;
    end
end

for i = 1 : length(binary_failure_vector_HECATE_LKA_OTA_3)
    j=0;
    if(binary_failure_vector_HECATE_LKA_OTA_3(i)==1)
        position_vector_HECATE_LKA_OTA_3 = [position_vector_HECATE_LKA_OTA_3, i];
        j=j+1;
    end
end




