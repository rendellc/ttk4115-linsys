% FOR HELICOPTER NR 3-10
run('../Common/init.m');

%% Part 3
A = [0 1 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     1 0 0 0 0;
     0 0 1 0 0];

B = [0 0;
     0 K1;
     K2 0;
     0 0;
     0 0];

C = [1 0 0 0 0;
     0 0 1 0 0];
 
D = zeros(2,2);

sys = ss(A,B,C,D);

disp(['Rank of ctrb = ', int2str(rank(ctrb(sys)))]);

Q = diag([0.67 0.1 0.1 4 1]);
R = diag([0.1 0.4]);
K = lqr(A,B,Q,R);

% Reference feedforward
%P = zeros(2,2);
P = [0 1; 
     4 0];

