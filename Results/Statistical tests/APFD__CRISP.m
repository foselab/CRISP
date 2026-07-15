%% AVARAGE PERCENTAGE FAULT DETECTION HECATE

%% ACC OTA 1 
% Data
n = length(vettore_fitness_HECATE_ACC_OTA_1); % number of tests
m = length(position_vector_HECATE_ACC_OTA_1); % number of faults
T = position_vector_HECATE_ACC_OTA_1; % index of the first test that identify a failure

% APFD
APFD_ACC_HECATE_OTA_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_HECATE_OTA_1)

%% ACC OTA 2
% Dati
n = length(vettore_fitness_HECATE_ACC_OTA_2); % number of test
m = length(position_vector_HECATE_ACC_OTA_2); % number of fault
T = position_vector_HECATE_ACC_OTA_2; % index of the first test that identify a failure

% Calcolo APFD
APFD_ACC_HECATE_OTA_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_ACC_HECATE_OTA_2)
%% APFD MEDIO ACC
%ancora da calcolare

%% LKA OTA 1 
n = length(vettore_fitness_HECATE_LKA_OTA_1); % number of tests
m = length(position_vector_HECATE_LKA_OTA_1); % number fault
T = position_vector_HECATE_LKA_OTA_1; % index of the first test that identify a failure

% Calcolo APFD
APFD_LKA_HECATE_OTA_1 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_HECATE_OTA_1)

%% LKA OTA 2
n = length(vettore_fitness_HECATE_LKA_OTA_2); % number of test
m = length(position_vector_HECATE_LKA_OTA_2); % number of fault
T = position_vector_HECATE_LKA_OTA_2; % index of the first test that identify a failure

% Calcolo APFD
APFD_LKA_HECATE_OTA_2 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_HECATE_OTA_2)

%% LKA OTA 3
n = length(vettore_fitness_HECATE_LKA_OTA_3); % number of test
m = length(position_vector_HECATE_LKA_OTA_3); % number of faults
T = position_vector_HECATE_LKA_OTA_3; % index of the first test that identify a failure

% Calcolo APFD
APFD_LKA_HECATE_OTA_3 = 1 - (sum(T) / (n * m)) + (1 / (2 * n));

fprintf('APFD = %.4f\n', APFD_LKA_HECATE_OTA_3)

