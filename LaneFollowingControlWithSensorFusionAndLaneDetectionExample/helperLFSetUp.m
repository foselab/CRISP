function helperLFSetUp(max_acceleration, min_acceleration, max_steering, min_steering, total_mass, yaw, long_distance_front, long_distance_rear, cornering_stiff_front, cornering_stiff_rear, tau, scenario_name, id_scenario, varargin)
% Set up Script for the Lane Following Example
%
% This script initializes the lane following example model. It loads
% necessary control constants and sets up the buses required for the
% referenced model.
%
%   This is a helper script for example purposes and may be removed or
%   modified in the future.

%   Copyright 2018-2020 The MathWorks, Inc.

%% General Model Parameters
assignin('base','Ts',0.01);               % Simulation sample time  (s)  %ho modificato questo, prima era 0.1

%% Path following Controller Parameters 
assignin('base','time_gap',1.5);                        % time gap               (s)
assignin('base','default_spacing',20);                  % default spacing        (m)
assignin('base','max_ac',max_acceleration);             % Maximum acceleration   (m/s^2)
assignin('base','min_ac',min_acceleration);             % Minimum acceleration   (m/s^2)
assignin('base','max_steer',max_steering);              % Maximum steering       (rad)
assignin('base','min_steer',min_steering);              % Minimum steering       (rad) 
assignin('base','PredictionHorizon',30);                % Prediction horizon     

%% Create driving scenario
% The scenario name is a MATLAB function created by the Driving Scenario Designer App. 
% defaultScenarioFcnName = "LFACC_04_Curve_CutInOut";
defaultScenarioFcnName = scenario_name;

%QUESTO E' QUELLO ORIGINALE CHE HO COMMENTANTO PER NON ELIMINARLO 
% validScenarioFcnNames = {
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
% scenarioStopTimes = [19.82 17.99 21.99 25.88 26.93 39.51 60.20 22.80 60.20];

validScenarioFcnNames = {
    'curvaLunga',...                                    % scenarioId = 1
    'LFACC_04_Curve_CutInOut',...                       % scenarioId = 2
    'LFACC_02_DoubleCurve_AutoRetarget',...             % scenarioId = 3
    };

scenarioStopTimes = [50.00 60.20 39.00];

% Parse input
checkScenarioFncName = @(x) any(strcmp(x,validScenarioFcnNames));
p = inputParser;
addOptional(p,'ScenarioFcnName',defaultScenarioFcnName,checkScenarioFncName);
parse(p,varargin{:});
scenarioFcnName = p.Results.ScenarioFcnName;
scenarioId = id_scenario;

%% Scenario parameters
% Set random seed to ensure reproducibility.
rng(0);

% Call scenario function to create drivingScenario and egoCar objects
[scenario, egoVehicle] = feval(scenarioFcnName);
assignin('base','scenario',scenario);
assignin('base','egoCarID',egoVehicle.ActorID);

% Initial condition for the ego car in ISO 8855 coordinates
v0_ego = norm(egoVehicle.Velocity);         % Initial speed of the ego car       (m/s)
x0_ego   = egoVehicle.Position(1);          % Initial x position of ego car      (m)
y0_ego   = egoVehicle.Position(2);          % Initial y position of ego car      (m)
yaw0_ego = deg2rad(egoVehicle.Yaw);         % Initial yaw angle of ego car        (rad)

% Convert ISO 8855 to SAE J670E coordinates and save to base workspace
assignin('base','v0_ego',v0_ego);
assignin('base','x0_ego',x0_ego);
assignin('base','y0_ego',-y0_ego);
assignin('base','yaw0_ego',-yaw0_ego);

% Define set velocity

v_set = 25;  % ACC set speed (m/s)

assignin('base','v_set',v_set);

% Define a simulation stop time
assignin('base','simStopTime',scenarioStopTimes(scenarioId));

%% Tracking and Sensor Fusion Parameters                        Units
assignin('base','assigThresh',50);    % Tracker assignment threshold          (N/A)
assignin('base','M',2);               % Tracker M value for M-out-of-N logic  (N/A)
assignin('base','N',3);               % Tracker M value for M-out-of-N logic  (N/A)
assignin('base','numCoasts',5);       % Number of track coasting steps        (N/A)
assignin('base','numTracks',100);     % Maximum number of tracks              (N/A)
assignin('base','numSensors',2);      % Maximum number of sensors             (N/A)

% Position and velocity selectors from track state
% The filter initialization function used in this example is initcvekf, which 
% defines a state that is: [x;vx;y;vy;z;vz]. 
assignin('base','posSelector',[1,0,0,0,0,0; 0,0,1,0,0,0]); % Position selector   (N/A)
assignin('base','velSelector',[0,1,0,0,0,0; 0,0,0,1,0,0]); % Velocity selector   (N/A)

%% Ego Car Parameters
% Dynamics modeling parameters
assignin('base','m',total_mass);                % Total mass of vehicle                          (kg)
assignin('base','Iz',yaw);                      % Yaw moment of inertia of vehicle               (m*N*s^2)
assignin('base','lf',long_distance_front);      % Longitudinal distance from c.g. to front tires (m)
assignin('base','lr',long_distance_rear);       % Longitudinal distance from c.g. to rear tires  (m)
assignin('base','Cf',cornering_stiff_front);    % Cornering stiffness of front tires             (N/rad)
assignin('base','Cr',cornering_stiff_rear);     % Cornering stiffness of rear tires              (N/rad)
assignin('base','tau',tau);                     % time constant for longitudinal dynamics        (1/s/(tau*s+1))

%% Bus Creation
% Load the Simulink model
modelName = 'LaneFollowingTestBenchExample';
wasModelLoaded = bdIsLoaded(modelName);
if ~wasModelLoaded
    load_system(modelName)
end

% Create custom left and right lanes bus
evalin('base','createLaneSensorBuses');

%Create buses for detections (Input to the referenced model)
blk=find_system(modelName,'System','visionDetectionGenerator');
visionDetectionGenerator.createBus(blk{1});
blk=find_system(modelName,'System','drivingRadarDataGenerator');
drivingRadarDataGenerator.createBus(blk{1});

% Create the bus of tracks (output from referenced model)
refModel = 'LFRefMdl';
wasReModelLoaded = bdIsLoaded(refModel);
if ~wasReModelLoaded
    load_system(refModel)
    blk=find_system(refModel,'System','multiObjectTracker');
    multiObjectTracker.createBus(blk{1});
    close_system(refModel)
else
    blk=find_system(refModel,'System','multiObjectTracker');
    multiObjectTracker.createBus(blk{1});
end

%% Code generation
% To generate code, uncomment the following commands.
% refModel = 'LFRefMdl';
% rtwbuild(refModel)
