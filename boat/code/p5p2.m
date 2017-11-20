load('wave.mat');
t = psi_w(1,:);
[pxx,f] = pwelch(psi_w(2,:), 4096, [],[]  ,10);
pxx = pxx*(1/(2*pi));
w = 2*pi*f;

[pmax, imax] = max(pxx);


w0_est = w(imax);

sigma = sqrt(pmax);
H = @(lambda, w) (2*lambda*w0_est*pmax).^2./((w0_est.^2-w.^2).^2 + (2*lambda*w0_est*sigma).^2); 
lambda_est = lsqcurvefit(H, 1, w', pxx');

disp('sigma = ' + string(sigma));
disp('lambda_est = ' + string(lambda_est));
disp('w0_est = ' + string(w0_est));

plot(w,H(lambda_est, w));
hold on;
plot(w,pxx);
