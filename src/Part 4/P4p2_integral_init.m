clear; clc;
run('../Common/init.m');

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

C_e = [1 0 0 0 0 0;
       0 0 1 0 0 0;
       0 0 0 0 1 0];

D_e = zeros(3,2);

sys_est = ss(A_e,B_e,C_e,D_e);

disp(['Rank of ctrb = ', int2str(rank(ctrb(sys_est)))]);

%% From problem 3
%run('../Part 3/P3p2_init.m'); % no integral
run('../Part 3/P3p3_init.m');  % with integral

%% observer
syscl = ss(A-B*K, B,C,D);
est_poles_rad = 20*max(abs(eig(syscl)));
est_poles_phi = linspace(-pi/4, pi/4, 6);
q = -est_poles_rad*exp(est_poles_phi*1i);
L_e = place(A_e', C_e', q).';

