%% CHEVROLET CAMARO 2024
%% all Parameters that define the vehicle 
total_mass = 1772;               % total mass of the vehicle                      (kg) 
yaw = 3499;                      % Yaw moment of inertia of vehicle               (m*N*s^2)
long_distance_front = 2.2;       % Longitudinal distance from c.g. to front tires (m)
long_distance_rear = 2.6;        % Longitudinal distance from c.g. to rear tires  (m)
cornering_stiff_front = 19000;   % Cornering stiffness of front tires             (N/rad)
cornering_stiff_rear = 33000;    % Cornering stiffness of rear tires              (N/rad)
tau = 0.5;                       % time constant for longitudinal dynamics        (1/s/(tau*s+1))
max_acceleration = 7.94;         % Maximum acceleration                           (m/s^2)
min_acceleration = -9.80;           % Minimum acceleration                           (m/s^2)
max_steering = 0.26;             % Maximum steering                               (rad)
min_steering = -0.26;            % Minimum steering                               (rad)  