%% Initial values
% found using signal statistics on scope block
amp1 = 29.360;
w1 = 0.005;

amp2 = 0.8315;
w2 = 0.05;

%% Solve for T and K
% see report for derivaion of this
T = sqrt(amp2^2*w2^2 - amp1^2*w1^2)/sqrt(amp1^2*w1^4 - amp2^2*w2^4);

% should be equal
K = amp1*w1*sqrt(T^2*w1^2 + 1);
K2 = amp2*w2*sqrt(T^2*w2^2 + 1); % for testing, gives same as above

%% Plot code

figure;
plot(simout);
hold on;

plot(simout1);
grid on;
title("Step response");
ylabel("Average heading \psi");
xlabel("Time (seconds)");

hold off;

