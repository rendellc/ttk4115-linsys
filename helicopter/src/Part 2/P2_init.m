run('../Common/init.m');

eig = -1.2 + 0.25*1i;

K_pp = abs(eig)^2*J_p/L1;
K_pd = -2*real(eig)*J_p/L1;

K_rp = -1.5;
rho = L4*K_rp;

