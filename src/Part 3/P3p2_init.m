run('../Common/init.m');

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
Q = diag([0.67 0.1 1]);
R = diag([0.01 0.04]);
K = lqr(A,B,Q,R);

% Reference feedforward
P = inv(C*(B*K-A)^-1*B);

