%% STATISTICAL TEST KS
%% statistical test 1: Kolmogorov-Smirnov (hecate vs other approaches OTA 1 ACC)


x_HECATE = position_vector_HECATE_ACC_OTA_1';
x_APDISC = position_vector_APDISC_ACC_OTA_1';
%x_APDISC = position_vector_RANDOM_MEDIO_ACC_OTA_1';

[h1, p1, ks2stat1] = kstest2(x_HECATE, x_APDISC)



%% statistical test 2: Kolmogorov-Smirnov (hecate vs other approaches OTA 2 ACC)


x_HECATE = position_vector_HECATE_ACC_OTA_2';
x_APDISC = position_vector_APDISC_ACC_OTA_2';

[h2, p2, ks2stat2] = kstest2(x_HECATE, x_APDISC)


%% statistical test 3: Kolmogorov-Smirnov (hecate vs other approaches OTA 1 LKA)


x_HECATE = position_vector_HECATE_LKA_OTA_1';
x_APDISC = position_vector_APDISC_LKA_OTA_1';

[h3, p3, ks2stat3] = kstest2(x_HECATE, x_APDISC)

%% statistical test 4: Kolmogorov-Smirnov (hecate vs other approaches OTA 2 LKA)


x_HECATE = position_vector_HECATE_LKA_OTA_2';
x_APDISC = position_vector_APDISC_LKA_OTA_2';

[h4, p4, ks2stat4] = kstest2(x_HECATE, x_APDISC)




%% statistical test 5: Kolmogorov-Smirnov (hecate vs other approaches OTA 3 LKA)

x_HECATE = position_vector_HECATE_LKA_OTA_3';
x_APDISC = position_vector_APDISC_LKA_OTA_3';   

[h5, p5, ks2stat5] = kstest2(x_HECATE, x_APDISC)














