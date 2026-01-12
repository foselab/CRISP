%% AUDI A4 2.0 TFSI AVANT 224 CV (2013-2015)
%% all Parameters that define the vehicle 
total_mass = 1580;               % total mass of the vehicle                      (kg) 
yaw = 3344;                      % Yaw moment of inertia of vehicle               (m*N*s^2)
long_distance_front = 1.4;      % Longitudinal distance from c.g. to front tires (m)
long_distance_rear = 1.4;       % Longitudinal distance from c.g. to rear tires  (m)
cornering_stiff_front = 19000;   % Cornering stiffness of front tires             (N/rad)
cornering_stiff_rear = 33000;    % Cornering stiffness of rear tires              (N/rad)
tau = 0.5;                       % time constant for longitudinal dynamics        (1/s/(tau*s+1))
max_acceleration = 3.91;         % Maximum acceleration                           (m/s^2)
min_acceleration = -11.3;        % Minimum acceleration                           (m/s^2)
max_steering = 0.26;             % Maximum steering                               (rad)
min_steering = -0.26;            % Minimum steering                               (rad)  


%% calcolo yaw 
% lo yaw moment of inertia può essere calcolato come: 
% I = massa * passo veicolo^2 * mu (tipicamente 0.27 per una station wagon)
% passo veicolo panda = 2808 mm