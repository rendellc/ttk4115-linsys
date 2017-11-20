% from problem 1
K = 0.1397; 
T = 70.2393;
Hship = tf([K], [T, 1, 0]);

% reference
psi_r = 30;


% PD-reg
Td = T;
wc = 0.1;
phi = 50; % deg
Tf = -1/(tan(deg2rad(180-phi))*wc);
Kpd = 1;
Hpd = tf([Kpd*Td, Kpd], [Tf, 1]);

bode(Hpd*Hship);

load('../../data/p3b.mat');
ts=ans;
