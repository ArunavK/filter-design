%Frequency Sampling method
%passband 0-5 kHz
%sampling freq = 18kHz
%filter length  = 9
N = 9;
alpha_c = N-1/2;
%H = 1 (k = 0, 1, 2)
%H = 0 (k = 3, 4)

H = [1 1 1 0 0 0 0 1 1]';
k = (0:N-1)';
n = 0:N-1;
h = (1/N) * (H(1) + sum(2*H(2:5) .* cos(2*pi*k(2:5)*(n-alpha_c)/N)));
display(h);