%% Parameters
run('common.m');
Fs = 10; % Sampling rate [Hz]
Ts = 1/Fs;

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

Qw = [30    0    ;
      0     1e-6];

%% Discretizing CT model using Van Loan's method
M = expm( [A              E*Qw*(E.'); 
           zeros(size(A)) -A.'     ] .*Ts);

N = expm( [A               B;
           zeros(size(B')) zeros(size(B,2))] .*Ts);

M11 = M(1:size(A,1),1:size(A,2));
M12 = M(1:size(A,1),size(A,2) + (1:size( E*Qw*(E.') ,2)));

N12 = N(1:size(B,1), size(A,2) + (1:size(B,2)));

Ad  = M11;
Qwd = M12 * M11.';
Bd  = N12;





