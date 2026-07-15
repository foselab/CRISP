%% AVARAGE PERCENTAGE FAULT DETECTION HECATE

%% ACC OTA 1 
% Dati
n = length(vettore_fitness_APDISC_ACC_OTA_1); % numero test
m = length(position_vector_APDISC_ACC_OTA_1); % numero fault
T = position_vector_APDISC_ACC_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_APDISC_OTA_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_APDISC_OTA_1)

%% ACC OTA 2
% Dati
n = length(vettore_fitness_APDISC_ACC_OTA_2); % numero test
m = length(position_vector_APDISC_ACC_OTA_2); % numero fault
T = position_vector_APDISC_ACC_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_ACC_APDISC_OTA_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_APDISC_OTA_2)
%% APFD MEDIO ACC
%ancora da calcolare

%% LKA OTA 1 
n = length(vettore_fitness_APDISC_LKA_OTA_1); % numero test
m = length(position_vector_APDISC_LKA_OTA_1); % numero fault
T = position_vector_APDISC_LKA_OTA_1; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_APDISC_OTA_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_APDISC_OTA_1)

%% LKA OTA 2
n = length(vettore_fitness_APDISC_LKA_OTA_2); % numero test
m = length(position_vector_APDISC_LKA_OTA_2); % numero fault
T = position_vector_APDISC_LKA_OTA_2; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_APDISC_OTA_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_APDISC_OTA_2)

%% LKA OTA 3
n = length(vettore_fitness_APDISC_LKA_OTA_3); % numero test
m = length(position_vector_APDISC_LKA_OTA_3); % numero fault
T = position_vector_APDISC_LKA_OTA_3; % indice del primo test che rileva ciascun fault

% Calcolo APFD
APFD_LKA_APDSIC_OTA_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_APDSIC_OTA_3)

