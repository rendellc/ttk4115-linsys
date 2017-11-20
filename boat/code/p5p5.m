%% Parameters
run('common.m');
Fs = 10; % Sampling rate [Hz]
Ts = 1/Fs;

%% Regulator

% from problem 1
K = 0.1397; 
T = 70.2393;
Hship = tf([K], [T, 1, 0]);

% reference
psi_r = 30; % [deg]


% PD-reg
Td = T;
wc = 0.1;
phi = 50; % deg
Tf = -1/(tan(deg2rad(180-phi))*wc);
Kpd = 1;
Hpd = tf([Kpd*Td, Kpd], [Tf, 1]);


%% Continous time LTI model
A = [0      1               0   0       0;
     -w0^2  -2*lambda*w0    0   0       0;
     0      0               0   1       0;
     0      0               0   -1/T    -K/T;
     0      0               0   0       0];
 
B = [0      0       0       K/T     0].';

E = [0      0;
     Kw     0;
     0      0;
     0      0;
     0      1];
C = [0  1   1   0   0];

Q = [30    0    ;
      0     1e-6];

%% Discretizing CT model using Van Loan's method

M = expm( [A              E*Q*(E.'); 
            zeros(size(A)) -A.'     ] .*Ts);
 
N = expm( [A               B;
            zeros(size(B')) zeros(size(B,2))] .*Ts);
 
M11 = M(1:size(A,1),1:size(A,2));
M12 = M(1:size(A,1),size(A,2) + (1:size( E*Q*(E.') ,2)));
 
N12 = N(1:size(B,1), size(A,2) + (1:size(B,2)));

Ad  = M11;
Qd = M12 * M11';
Bd  = N12;

%[Ad, Bd] = c2d(A,B,Ts);
[Ad, Ed] = c2d(A,E,Ts);

%% Variance of measurement noise
d = load('../data/p5_var_measurement.mat');
d = d.ans;

R = var(d.Data(:));
Rd = R/Ts;

%% Filter

% Ak = A;
% Bk = [0      0;
%       0      0;
%       1      0;
%       0      K/T;
%       0      0];
% Ck = [0  0   1   0   0;
%       0  0   0   0   1];

x0_minus = [0   0   0   0   0].';

P0_minus = [1   0       0       0   0;
            0   0.013   0       0   0;
            0   0       pi^2    0   0;
            0   0       0       1   0;
            0   0       0       0   2.5e-3];
        
%P0_minusvec = P0_minus(:);
        
%P0_minusmat = reshape(P0_minusvec, sqrt(length(P0_minusvec)),sqrt(length(P0_minusvec)));

data = struct('Ad', Ad, 'Bd', Bd, 'C', C, 'Ed', Ed, 'Qd', Qd, 'Rd', Rd, ... 
              'P0_minus', P0_minus, 'x0_minus', x0_minus);

          
          
          
          
          
          
          
          