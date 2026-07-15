%% A12

%% ACC OTA 1
gruppoA = position_vector_HECATE_ACC_OTA_1;
gruppoB = position_vector_APDISC_ACC_OTA_1;

% data must be in a column vector
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% Calculate sample sizes
m = length(gruppoA);
n = length(gruppoB);

% Run the ranksum test to get the sum of the ranks of group A
[p, h, stats] = ranksum(gruppoA, gruppoB);

% Rank sum for group A (stats.ranksum)
R_A = stats.ranksum;

% Calculate the U statistic for group A
U_A = R_A - (m * (m + 1) / 2);

% Calculate the effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% print results
fprintf('The statistic A12 (probability that A < B) is (ACC OTA 1): %.4f\n', A12_CORRETTO);

%% ACC OTA 2

gruppoA = position_vector_HECATE_ACC_OTA_2;
gruppoB = position_vector_APDISC_ACC_OTA_2;

% data must be in a column vector
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% Calculate sample sizes
m = length(gruppoA);
n = length(gruppoB);

% Run the ranksum test to get the sum of the ranks of group A
[p, h, stats] = ranksum(gruppoA, gruppoB);

% Rank sum for group A (stats.ranksum)
R_A = stats.ranksum;

% Calculate the U statistic for group A
U_A = R_A - (m * (m + 1) / 2);

% Calculate the effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% print results
fprintf('The statistic A12 (probability that A < B) is  (ACC OTA 2): %.4f\n', A12_CORRETTO);

%% LKA OTA 1

gruppoA = position_vector_HECATE_LKA_OTA_1;
gruppoB = position_vector_APDISC_LKA_OTA_1;

% data must be in a column vector
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% Calculate sample sizes
m = length(gruppoA);
n = length(gruppoB);

% Run the ranksum test to get the sum of the ranks of group A

[p, h, stats] = ranksum(gruppoA, gruppoB);

% Rank sum for group A (stats.ranksum)
R_A = stats.ranksum;

% Calculate the U statistic for group A
U_A = R_A - (m * (m + 1) / 2);

% Calculate the effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% print results
fprintf('The statistic A12 (probability that A < B) is (LKA OTA 1): %.4f\n', A12_CORRETTO);

%% LKA OTA 2

gruppoA = position_vector_HECATE_LKA_OTA_2;
gruppoB = position_vector_APDISC_LKA_OTA_2;

% data must be in a column vector
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% Calculate sample sizes
m = length(gruppoA);
n = length(gruppoB);

% Run the ranksum test to get the sum of the ranks of group A

[p, h, stats] = ranksum(gruppoA, gruppoB);

% Rank sum for group A (stats.ranksum)
R_A = stats.ranksum;

% Calculate the U statistic for group A
U_A = R_A - (m * (m + 1) / 2);

% Calculate the effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% print results
fprintf('The statistic A12 (probability that A < B) is (LKA OTA 2): %.4f\n', A12_CORRETTO);

%% LKA OTA 3

gruppoA = position_vector_HECATE_LKA_OTA_3;
gruppoB = position_vector_APDISC_LKA_OTA_3;

% data must be in a column vector
gruppoA = gruppoA(:);
gruppoB = gruppoB(:);

% Calculate sample sizes
m = length(gruppoA);
n = length(gruppoB);

% Run the ranksum test to get the sum of the ranks of group A

[p, h, stats] = ranksum(gruppoA, gruppoB);

% Rank sum for group A (stats.ranksum)
R_A = stats.ranksum;

% Calculate the U statistic for group A
U_A = R_A - (m * (m + 1) / 2);

% Calculate the effect size A12
A12 = U_A / (m * n);
A12_CORRETTO = 1-A12;

% print results
fprintf('The statistic A12 (probability that A < B) is (LKA OTA 3): %.4f\n', A12_CORRETTO);