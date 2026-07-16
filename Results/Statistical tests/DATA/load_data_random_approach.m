%% data extraction ACC OTA 1
T1 = readtable('tabellarisultatiRandom_CONF1_RUN_1_finale.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
position_vector_RANDOM_1_ACC_OTA_1 = [];

for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i=1:length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1_ACC_OTA_1 = [position_vector_RANDOM_1_ACC_OTA_1,i];
        j=j+1;
    end
end


binary_failure_vector_1 = cumsum(binary_failure_vector_1);

% --------------------------------------------------------------------------

T2 = readtable('tabellarisultatiRandom_CONF1_RUN_2_finale.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
position_vector_RANDOM_2_ACC_OTA_1 = [];

for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i=1:length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2_ACC_OTA_1 = [position_vector_RANDOM_2_ACC_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

% --------------------------------------------------------------------------

T3 = readtable('tabellarisultatiRandom_CONF1_RUN_3_finale.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
position_vector_RANDOM_3_ACC_OTA_1 = [];

for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i=1:length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3_ACC_OTA_1 = [position_vector_RANDOM_3_ACC_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

% --------------------------------------------------------------------------

T4 = readtable('tabellarisultatiRandom_CONF1_RUN_4_finale.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
position_vector_RANDOM_4_ACC_OTA_1 = [];

for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i=1:length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4_ACC_OTA_1 = [position_vector_RANDOM_4_ACC_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

% --------------------------------------------------------------------------

T5 = readtable('tabellarisultatiRandom_CONF1_RUN_5_finale.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
position_vector_RANDOM_5_ACC_OTA_1 = [];

for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i=1:length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5_ACC_OTA_1 = [position_vector_RANDOM_5_ACC_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);

% --------------------------------------------------------------------------


vettore_failure_medio_ACC_CONF1_RAND = zeros(1,length(binary_failure_vector_1));

position_vector_RANDOM_MEDIO_ACC_OTA_1 = mean([position_vector_RANDOM_1_ACC_OTA_1; position_vector_RANDOM_2_ACC_OTA_1; position_vector_RANDOM_3_ACC_OTA_1; position_vector_RANDOM_4_ACC_OTA_1; position_vector_RANDOM_5_ACC_OTA_1], 1);


for j=1:length(binary_failure_vector_1)
    summa = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = summa/5; 
    vettore_failure_medio_ACC_CONF1_RAND(j)=valore_medio; 
end


%% data extraction ACC OTA 2
T1 = readtable('tabellarisultati_RANDOM1_CONF_2.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
position_vector_RANDOM_1_ACC_OTA_2 = [];

for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i=1:length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1_ACC_OTA_2 = [position_vector_RANDOM_1_ACC_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

% --------------------------------------------------------------------------

T2 = readtable('tabellarisultati_RANDOM2_CONF_2.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
position_vector_RANDOM_2_ACC_OTA_2 = [];

for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i=1:length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2_ACC_OTA_2 = [position_vector_RANDOM_2_ACC_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

% --------------------------------------------------------------------------

T3 = readtable('tabellarisultati_RANDOM3_CONF_2.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
position_vector_RANDOM_3_ACC_OTA_2 = [];

for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i=1:length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3_ACC_OTA_2 = [position_vector_RANDOM_3_ACC_OTA_2,i];
        j=j+1;
    end
end
binary_failure_vector_3 = cumsum(binary_failure_vector_3);

% --------------------------------------------------------------------------

T4 = readtable('tabellarisultati_RANDOM4_CONF_2.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
position_vector_RANDOM_4_ACC_OTA_2 = [];

for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i=1:length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4_ACC_OTA_2 = [position_vector_RANDOM_4_ACC_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

% --------------------------------------------------------------------------

T5 = readtable('tabellarisultati_RANDOM5_CONF_2.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
position_vector_RANDOM_5_ACC_OTA_2 = [];

for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i=1:length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5_ACC_OTA_2 = [position_vector_RANDOM_5_ACC_OTA_2,i];
        j=j+1;
    end
end


binary_failure_vector_5 = cumsum(binary_failure_vector_5);

% --------------------------------------------------------------------------


vettore_failure_medio_ACC_CONF2_RAND = zeros(1,length(binary_failure_vector_1));

position_vector_RANDOM_MEDIO_ACC_OTA_2 = mean([position_vector_RANDOM_1_ACC_OTA_2; position_vector_RANDOM_2_ACC_OTA_2; position_vector_RANDOM_3_ACC_OTA_2; position_vector_RANDOM_4_ACC_OTA_2; position_vector_RANDOM_5_ACC_OTA_2], 1);



for j=1:length(binary_failure_vector_1)
    summa = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = summa/5; 
    vettore_failure_medio_ACC_CONF2_RAND(j)=valore_medio; 
end


%% data extraction LKA OTA 1
T1 = readtable('tabellarisultati_LKA_CONF1_RANDOM_1.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
position_vector_RANDOM_1_LKA_OTA_1 = [];

for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i=1:length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1_LKA_OTA_1 = [position_vector_RANDOM_1_LKA_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

% --------------------------------------------------------------------------

T2 = readtable('tabellarisultati_LKA_CONF1_RANDOM_2.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
position_vector_RANDOM_2_LKA_OTA_1 = [];

for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i=1:length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2_LKA_OTA_1 = [position_vector_RANDOM_2_LKA_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

% --------------------------------------------------------------------------

T3 = readtable('tabellarisultati_LKA_CONF1_RANDOM_3.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
position_vector_RANDOM_3_LKA_OTA_1 = [];

for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i=1:length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3_LKA_OTA_1 = [position_vector_RANDOM_3_LKA_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

% --------------------------------------------------------------------------

T4 = readtable('tabellarisultati_LKA_CONF1_RANDOM_4.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
position_vector_RANDOM_4_LKA_OTA_1 = [];

for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i=1:length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4_LKA_OTA_1 = [position_vector_RANDOM_4_LKA_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

% --------------------------------------------------------------------------

T5 = readtable('tabellarisultati_LKA_CONF1_RANDOM_5.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
position_vector_RANDOM_5_LKA_OTA_1 = [];

for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i=1:length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5_LKA_OTA_1 = [position_vector_RANDOM_5_LKA_OTA_1,i];
        j=j+1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);

% --------------------------------------------------------------------------


vettore_failure_medio_LKA_CONF1_RAND = zeros(1,length(binary_failure_vector_1));
position_vector_RANDOM_MEDIO_LKA_OTA_1 = mean([position_vector_RANDOM_1_LKA_OTA_1; position_vector_RANDOM_2_LKA_OTA_1; position_vector_RANDOM_3_LKA_OTA_1; position_vector_RANDOM_4_LKA_OTA_1; position_vector_RANDOM_5_LKA_OTA_1], 1);



for j=1:length(binary_failure_vector_1)
    summa = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = summa/5; 
    vettore_failure_medio_LKA_CONF1_RAND(j)=valore_medio; 
end


%% data extraction LKA OTA 2
T1 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_1.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
position_vector_RANDOM_1_LKA_OTA_2 = [];

for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i=1:length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1_LKA_OTA_2 = [position_vector_RANDOM_1_LKA_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

% --------------------------------------------------------------------------

T2 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_2.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
position_vector_RANDOM_2_LKA_OTA_2 = [];

for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i=1:length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2_LKA_OTA_2 = [position_vector_RANDOM_2_LKA_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

% --------------------------------------------------------------------------

T3 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_3.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
position_vector_RANDOM_3_LKA_OTA_2 = [];

for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i=1:length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3_LKA_OTA_2 = [position_vector_RANDOM_3_LKA_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

% --------------------------------------------------------------------------

T4 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_4.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
position_vector_RANDOM_4_LKA_OTA_2 = [];

for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i=1:length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4_LKA_OTA_2 = [position_vector_RANDOM_4_LKA_OTA_2,i];
        j=j+1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

% --------------------------------------------------------------------------

T5 = readtable('tabellarisultati_LKA_CONF_2_RANDOM_5.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
position_vector_RANDOM_5_LKA_OTA_2 = [];

for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i=1:length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5_LKA_OTA_2 = [position_vector_RANDOM_5_LKA_OTA_2,i];
        j=j+1;
    end
end
binary_failure_vector_5 = cumsum(binary_failure_vector_5);

% --------------------------------------------------------------------------


vettore_failure_medio_LKA_CONF2_RAND = zeros(1,length(binary_failure_vector_1));
position_vector_RANDOM_MEDIO_LKA_OTA_2 = mean([position_vector_RANDOM_1_LKA_OTA_2; position_vector_RANDOM_2_LKA_OTA_2; position_vector_RANDOM_3_LKA_OTA_2; position_vector_RANDOM_4_LKA_OTA_2; position_vector_RANDOM_5_LKA_OTA_2], 1);



for j=1:length(binary_failure_vector_1)
    summa = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = summa/5; 
    vettore_failure_medio_LKA_CONF2_RAND(j)=valore_medio; 
end


%% data extraction LKA OTA 3
T1 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_1.xlsx');
vettore_failure_1 = double(T1{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_1 = zeros(1,length(vettore_failure_1));
position_vector_RANDOM_1_LKA_OTA_3 = [];

for i=1:length(vettore_failure_1)
    if(vettore_failure_1(i)<0)
        binary_failure_vector_1(i)=1;
    end
end

for i=1:length(binary_failure_vector_1)
    j=0;
    if(binary_failure_vector_1(i)==1)
        position_vector_RANDOM_1_LKA_OTA_3 = [position_vector_RANDOM_1_LKA_OTA_3,i];
        j=j+1;
    end
end

binary_failure_vector_1 = cumsum(binary_failure_vector_1);

% --------------------------------------------------------------------------

T2 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_2.xlsx');
vettore_failure_2 = double(T2{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_2 = zeros(1,length(vettore_failure_2));
position_vector_RANDOM_2_LKA_OTA_3 = [];

for i=1:length(vettore_failure_2)
    if(vettore_failure_2(i)<0)
        binary_failure_vector_2(i)=1;
    end
end

for i=1:length(binary_failure_vector_2)
    j=0;
    if(binary_failure_vector_2(i)==1)
        position_vector_RANDOM_2_LKA_OTA_3 = [position_vector_RANDOM_2_LKA_OTA_3,i];
        j=j+1;
    end
end

binary_failure_vector_2 = cumsum(binary_failure_vector_2);

% --------------------------------------------------------------------------

T3 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_3.xlsx');
vettore_failure_3 = double(T3{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_3 = zeros(1,length(vettore_failure_3));
position_vector_RANDOM_3_LKA_OTA_3 = [];

for i=1:length(vettore_failure_3)
    if(vettore_failure_3(i)<0)
        binary_failure_vector_3(i)=1;
    end
end

for i=1:length(binary_failure_vector_3)
    j=0;
    if(binary_failure_vector_3(i)==1)
        position_vector_RANDOM_3_LKA_OTA_3 = [position_vector_RANDOM_3_LKA_OTA_3,i];
        j=j+1;
    end
end

binary_failure_vector_3 = cumsum(binary_failure_vector_3);

% --------------------------------------------------------------------------

T4 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_4.xlsx');
vettore_failure_4 = double(T4{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_4 = zeros(1,length(vettore_failure_4));
position_vector_RANDOM_4_LKA_OTA_3 = [];

for i=1:length(vettore_failure_4)
    if(vettore_failure_4(i)<0)
        binary_failure_vector_4(i)=1;
    end
end

for i=1:length(binary_failure_vector_4)
    j=0;
    if(binary_failure_vector_4(i)==1)
        position_vector_RANDOM_4_LKA_OTA_3 = [position_vector_RANDOM_4_LKA_OTA_3,i];
        j=j+1;
    end
end

binary_failure_vector_4 = cumsum(binary_failure_vector_4);

% --------------------------------------------------------------------------

T5 = readtable('tabellarisultati_LKA_CONF_3_RANDOM_5.xlsx');
vettore_failure_5 = double(T5{1:end, 3}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
binary_failure_vector_5 = zeros(1,length(vettore_failure_5));
position_vector_RANDOM_5_LKA_OTA_3 = [];

for i=1:length(vettore_failure_5)
    if(vettore_failure_5(i)<0)
        binary_failure_vector_5(i)=1;
    end
end

for i=1:length(binary_failure_vector_5)
    j=0;
    if(binary_failure_vector_5(i)==1)
        position_vector_RANDOM_5_LKA_OTA_3 = [position_vector_RANDOM_5_LKA_OTA_3,i];
        j=j+1;
    end
end

binary_failure_vector_5 = cumsum(binary_failure_vector_5);

% --------------------------------------------------------------------------


vettore_failure_medio_LKA_CONF3_RAND = zeros(1,length(binary_failure_vector_1));
position_vector_RANDOM_MEDIO_LKA_OTA_3 = mean([position_vector_RANDOM_1_LKA_OTA_3; position_vector_RANDOM_2_LKA_OTA_3; position_vector_RANDOM_3_LKA_OTA_3; position_vector_RANDOM_4_LKA_OTA_3; position_vector_RANDOM_5_LKA_OTA_3], 1);



for j=1:length(binary_failure_vector_1)
    summa = binary_failure_vector_1(j)+binary_failure_vector_2(j)+binary_failure_vector_3(j)+binary_failure_vector_4(j)+binary_failure_vector_5(j);
    valore_medio = summa/5; 
    vettore_failure_medio_LKA_CONF3_RAND(j)=valore_medio; 
end

