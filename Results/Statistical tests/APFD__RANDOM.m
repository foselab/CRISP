%% AVARAGE PERCENTAGE FAULT DETECTION RANDOM APPROACH

%% ACC OVER THE AIR UPDATE 1 ----------------------------------------------------------------------------------------------------------------------------------

% ACC OTA 1 RANDOM 1
% Dati
n = 133; % numero test
m = 46; % numero fault
T = position_vector_RANDOM_1_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_1_RANDOM_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_1_RANDOM_1)

% ACC OTA 1 RANDOM 2
% Dati
n = 133; % numero test
m = 46; % numero fault
T = position_vector_RANDOM_2_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_1_RANDOM_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_1_RANDOM_2)


% ACC OTA 1 RANDOM 3
% Dati
n = 133; % numero test
m = 46; % numero fault
T = position_vector_RANDOM_3_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_1_RANDOM_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_1_RANDOM_3)

% ACC OTA 1 RANDOM 4
% Dati
n = 133; % numero test
m = 46; % numero fault
T = position_vector_RANDOM_4_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_1_RANDOM_4 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_1_RANDOM_4)

% ACC OTA 1 RANDOM 5
% Dati
n = 133; % numero test
m = 46; % numero fault
T = position_vector_RANDOM_5_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_1_RANDOM_5 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_1_RANDOM_5)


%CALCOLO APFD MEDIA 
APFD_ACC_OTA_1_RANDOM_MEDIO = (APFD_ACC_OTA_1_RANDOM_1 + APFD_ACC_OTA_1_RANDOM_2 + APFD_ACC_OTA_1_RANDOM_3 + APFD_ACC_OTA_1_RANDOM_4 + APFD_ACC_OTA_1_RANDOM_5)/5;

%% ACC OVER THE AIR UPDATE 2 ---------------------------------------------------------------------------------------------------------------------------------
% ACC OTA 2 RANDOM 1
% Dati
n = 133; % numero test
m = 23; % numero fault
T = position_vector_RANDOM_1_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_2_RANDOM_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_2_RANDOM_1)

% ACC OTA 2 RANDOM 2
% Dati
n = 133; % numero test
m = 23; % numero fault
T = position_vector_RANDOM_2_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_2_RANDOM_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_2_RANDOM_2)


% ACC OTA 2 RANDOM 3
% Dati
n = 133; % numero test
m = 23; % numero fault
T = position_vector_RANDOM_3_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_2_RANDOM_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_2_RANDOM_3)

% ACC OTA 2 RANDOM 4
% Dati
n = 133; % numero test
m = 23; % numero fault
T = position_vector_RANDOM_4_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_2_RANDOM_4 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_2_RANDOM_4)

% ACC OTA 2 RANDOM 5
% Dati
n = 133; % numero test
m = 23; % numero fault
T = position_vector_RANDOM_5_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_OTA_2_RANDOM_5 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_OTA_2_RANDOM_5)

%CALCOLO APFD MEDIA 
APFD_ACC_OTA_2_RANDOM_MEDIO = (APFD_ACC_OTA_2_RANDOM_1 + APFD_ACC_OTA_2_RANDOM_2 + APFD_ACC_OTA_2_RANDOM_3 + APFD_ACC_OTA_2_RANDOM_4 + APFD_ACC_OTA_2_RANDOM_5)/5;


%% LKA OVER THE AIR UPDATE 1 ---------------------------------------------------------------------------------------------------------------------------------
% LKA OTA 1 RANDOM 1
% Dati
n = 91; % numero test
m = 33; % numero fault
T = position_vector_RANDOM_1_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_1_RANDOM_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_1_RANDOM_1)

% LKA OTA 1 RANDOM 2
% Dati
n = 91; % numero test
m = 33; % numero fault
T = position_vector_RANDOM_2_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_1_RANDOM_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_1_RANDOM_2)

% LKA OTA 1 RANDOM 3
% Dati
n = 91; % numero test
m = 33; % numero fault
T = position_vector_RANDOM_3_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_1_RANDOM_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_1_RANDOM_3)

% LKA OTA 1 RANDOM 3
% Dati
n = 91; % numero test
m = 33; % numero fault
T = position_vector_RANDOM_4_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_1_RANDOM_4 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_1_RANDOM_4)

% LKA OTA 1 RANDOM 3
% Dati
n = 91; % numero test
m = 33; % numero fault
T = position_vector_RANDOM_5_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_1_RANDOM_5 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_1_RANDOM_5)

%CALCOLO APFD MEDIA 
APFD_LKA_OTA_1_RANDOM_MEDIO = (APFD_LKA_OTA_1_RANDOM_1 + APFD_LKA_OTA_1_RANDOM_2 + APFD_LKA_OTA_1_RANDOM_3 + APFD_LKA_OTA_1_RANDOM_4 + APFD_LKA_OTA_1_RANDOM_5)/5;


%% LKA OVER THE AIR UPDATE 2 ---------------------------------------------------------------------------------------------------------------------------------
% LKA OTA 2 RANDOM 1
% Dati
n = 91; % numero test
m = 25; % numero fault
T = position_vector_RANDOM_1_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_2_RANDOM_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_2_RANDOM_1)

% LKA OTA 2 RANDOM 2
% Dati
n = 91; % numero test
m = 25; % numero fault
T = position_vector_RANDOM_2_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_2_RANDOM_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_2_RANDOM_2)

% LKA OTA 2 RANDOM 3
% Dati
n = 91; % numero test
m = 25; % numero fault
T = position_vector_RANDOM_3_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_2_RANDOM_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_2_RANDOM_3)

% LKA OTA 2 RANDOM 4
% Dati
n = 91; % numero test
m = 25; % numero fault
T = position_vector_RANDOM_4_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_2_RANDOM_4= 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_2_RANDOM_4)


% LKA OTA 2 RANDOM 5
% Dati
n = 91; % numero test
m = 25; % numero fault
T = position_vector_RANDOM_5_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_2_RANDOM_5= 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_2_RANDOM_5)

%CALCOLO APFD MEDIA 
APFD_LKA_OTA_2_RANDOM_MEDIO = (APFD_LKA_OTA_2_RANDOM_1 + APFD_LKA_OTA_2_RANDOM_2 + APFD_LKA_OTA_2_RANDOM_3 + APFD_LKA_OTA_2_RANDOM_4 + APFD_LKA_OTA_2_RANDOM_5)/5;

%% LKA OVER THE AIR UPDATE 3 ---------------------------------------------------------------------------------------------------------------------------------
% LKA OTA 3 RANDOM 1
% Dati
n = 91; % numero test
m = 7; % numero fault
T = position_vector_RANDOM_1_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_3_RANDOM_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_3_RANDOM_1)

% LKA OTA 3 RANDOM 2
% Dati
n = 91; % numero test
m = 7; % numero fault
T = position_vector_RANDOM_2_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_3_RANDOM_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_3_RANDOM_2)

% LKA OTA 3 RANDOM 3
% Dati
n = 91; % numero test
m = 7; % numero fault
T = position_vector_RANDOM_3_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_3_RANDOM_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_3_RANDOM_3)

% LKA OTA 3 RANDOM 4
% Dati
n = 91; % numero test
m = 7; % numero fault
T = position_vector_RANDOM_4_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_3_RANDOM_4 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_3_RANDOM_4)

% LKA OTA 3 RANDOM 5
% Dati
n = 91; % numero test
m = 7; % numero fault
T = position_vector_RANDOM_5_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_OTA_3_RANDOM_5 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_OTA_3_RANDOM_5)

%CALCOLO APFD MEDIA 
APFD_LKA_OTA_3_RANDOM_MEDIO = (APFD_LKA_OTA_3_RANDOM_1 + APFD_LKA_OTA_3_RANDOM_2 + APFD_LKA_OTA_3_RANDOM_3 + APFD_LKA_OTA_3_RANDOM_4 + APFD_LKA_OTA_3_RANDOM_5)/5;


VETTORE_MEDIO_APFD = [APFD_ACC_OTA_1_RANDOM_MEDIO APFD_ACC_OTA_2_RANDOM_MEDIO APFD_LKA_OTA_1_RANDOM_MEDIO APFD_LKA_OTA_2_RANDOM_MEDIO APFD_LKA_OTA_3_RANDOM_MEDIO];

