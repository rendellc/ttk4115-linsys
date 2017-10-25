%% observer
syscl = ss(A-B*K, B,C,D);
pf = 20; % poleplacement for estimator poles v. system poles
est_poles_rad = pf*max(abs(eig(syscl)));
est_poles_phi = linspace(-pi/4, pi/4, 6);
q = -est_poles_rad*exp(est_poles_phi*1i);
L_e = place(A_e', C_e', q).';