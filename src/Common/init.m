%% Calibration of the encoder and the hardware for the specific helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;

%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]

%% Settings
elevation_offset = 30;  % [deg]
Vs_star_meas = 7.05;    % Problem 5.1.4
Kf = (-l_c*m_c*g + 2*l_h*m_p*g)/(l_h*Vs_star_meas);

L1 = l_p*Kf;
L2 = l_c*m_c*g - 2*l_h*m_p*g;
L3 = l_h*Kf;
L4 = -l_h*Kf;

J_p = 2*m_p*l_p^2;
J_e = m_c*l_c^2 + 2*m_p*l_h^2;
J_lambda = m_c*l_c^2 + 2*m_p*(l_h^2 + l_p^2);

K1 = L1/J_p;
K2 = L3/J_e;
K3 = L4/J_lambda;

