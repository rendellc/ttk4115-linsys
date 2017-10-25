% FOR HELICOPTER NR 3-10
clear; clc;
run('../Common/init.m');

%% Part 3

A_e = [0  1 0 0 0 0;
       0  0 0 0 0 0;
       0  0 0 1 0 0;
       0  0 0 0 0 0;
       0  0 0 0 0 1;
       K3 0 0 0 0 0];

B_e = [0  0;
       0  K1;
       0  0;
       K2 0;
       0  0;
       0  0];

C_e = [0 0 1 0 0 0;
       0 0 0 0 1 0];

D_e = zeros(2,2);

sys_est = ss(A_e,B_e,C_e,D_e);

disp(['Rank of ctrb = ', int2str(rank(ctrb(sys_est)))]);
disp(['Rank of obsv = ', int2str(rank(obsv(sys_est)))]);

%% From P3p2 (without integral)
A = [0 1 0;
     0 0 0;
     0 0 0];

B = [0 0;
     0 K1;
     K2 0];
 
C = [1 0 0;
     0 0 1];
 
D = zeros(2,2);

sys = ss(A,B,C,D);

disp(['Rank of ctrb = ', int2str(rank(ctrb(sys)))]);

% LQR
Q = diag([2.5 0.01 30]); %Q = diag([2 0.01 30]);
R = diag([100 70]);
K = lqr(A,B,Q,R);

% Reference feedforward
P = inv(C*(B*K-A)^-1*B);

%% observer
syscl = ss(A-B*K,B,C,D);
est_poles_rad = 1.4*max(abs(eig(syscl)));
est_poles_phi = linspace(-pi/4, pi/4, 6);
q_untuned = -est_poles_rad*exp(est_poles_phi*1i);

abs(eig(syscl))
q_tuned = -0.39*[0.9 1 1.1 1.2 1+0.7i 1-0.7i];

q = q_untuned
L_e = place(A_e', C_e', q).'
A_e-L_e*C_e




