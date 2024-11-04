%% INTRODUZIONE
% QUESTO FILE SERVE PER ANDARE A RUNNARE IN UN CICLO TUTTE LE POSSIBILI
% COMBINAZIONI TRA AUTOMOBILI, SCENARI E COMPONENTISTICA DISPONIBILE.
modelname_simulation = 'LaneFollowingTestBenchExample';

%% elenco automobili disponibili (organizzato in un vettore di celle) 
% IMPORTANTE!! ogni volta che si crea un nuovo veicolo bisogna inserire il
% nome del file all'interno di questo array
Vehicles_Parameters = {
    'HummerEV.m',...        % VehicleId = 1
    'Malibu.m',...          % VehicleId = 2
    'Camaro.m',...          % VehicleId = 3
    };

%Default_Vehicle = "Malibu.m"; 
%run(Default_Vehicle);  % questo mi serviva solo per provare che runnasse correttamente, poi verrà tolto

% helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau)

%% elenco possibili scenari (organizzato in un vettore di celle)
% Scenario_Array = {
%     'ACC_01_ISO_TargetDiscriminationTest',...          % scenarioId = 1
%     'ACC_02_ISO_AutoRetargetTest',...                  % scenarioId = 2
%     'ACC_03_ISO_CurveTest',...                         % scenarioId = 3
%     'ACC_04_StopnGo',...                               % scenarioId = 4
%     'LFACC_01_DoubleCurve_DecelTarget',...             % scenarioId = 5
%     'LFACC_02_DoubleCurve_AutoRetarget',...            % scenarioId = 6
%     'scenarioOstacoloSuStrada',...                     % scenarioId = 7
%     'LFACC_04_Curve_CutInOut',...                      % scenarioId = 8
%     'selvinotest',...                                  % scenarioId = 9
%     };
% 
% StopTimes = [19.82 17.99 21.99 25.88 26.93 39.51 60.20 22.80 60.20];


%% funzione ciclica che va a runnare tutte le possibili configurazioni
% for i = 1 : lenght(Vehicles_Array)
%     run(Vehicles_Array{i});
%     for j = 1 : lenght(Scenario_Array)
% 
%     end
% end
lenght_array = length(Vehicles_Array);
for i = 1 : lenght_array
    run(Vehicles_Parameters{i});
    helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau);
    sim(modelname_simulation);
end