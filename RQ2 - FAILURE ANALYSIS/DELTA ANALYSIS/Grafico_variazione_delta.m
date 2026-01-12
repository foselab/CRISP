%% PERCENTAGE OF FAULT DETECTED FUNCTION OF DELTA VARIATIONS 
%estraggo i dati dalla tabella
T1 = readtable('variazione_delta_complessiva.xlsx');
vettore_percentuale_fault = double(T1{1:end, 8}); % estraggo la colonna delle collisioni escludendo la prima riga di intestazione
vettore_delta =double(T1{1:end, 10});
figure;
plot(vettore_delta,vettore_percentuale_fault,LineWidth=1.5,Marker="o");
hold on; 
title("Percentage of Failures Detected as a Function of Delta");
xlabel("delta threshold");
ylabel("percentage of fault detected");
grid on;
hold off


%% TIME SAVED FUNCTION OF DELTA VARIATIONS
%EXTRACT DATA FROM THE TABLE
T2 =readtable('variazione_delta_complessiva.xlsx');
vector_time_saved = double(T2{1:end,15});
vector_delta = double(T1{1:end,10}); 
figure;
plot(vector_delta,vector_time_saved,LineWidth=1.5,Marker="o",Color="red");
hold on; 
title("Time saved as a Function of Delta");
xlabel("delta threshold");
ylabel("Time saved (s)");
grid on;
hold off

%% ONE GRAPH COMBINED
figure;
title("Trade-off Between Fault Detection Performance and Time Saving Across Δ Values");
yyaxis left
plot(vettore_delta,vettore_percentuale_fault, 'LineWidth', 1.5)
ylabel("percentage of fault detected")

yyaxis right
plot(vector_delta,vector_time_saved, 'LineWidth', 1.5)
ylabel("Time saved (s)")
xlabel("delta threshold");
