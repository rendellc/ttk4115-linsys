function [K, T]  = calculate_K_and_T(w1, amp1, w2, amp2)

% see report for derivaion of this
T = sqrt(amp2^2*w2^2 - amp1^2*w1^2)/sqrt(amp1^2*w1^4 - amp2^2*w2^4);

% should be equal
K = amp1*w1*sqrt(T^2*w1^2 + 1);
%K2 = amp2*w2*sqrt(T^2*w2^2 + 1); % for testing, gives same as above