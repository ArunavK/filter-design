clc;
clear;

%desired filter specs
Wp_cap = 2*pi*4000; %passband edge frequency in rad/s
Ws_cap = 2*pi*1000; %stopband edge frequency in rad/s
Rp = 0.1; %passband attenuation in dB
Rs = 40; %stopband attenuation in dB

%prototype LP filter specs
Wp = 1;
Ws = Wp*Wp_cap/Ws_cap;
fprintf("LP prototype specs:\nWp = %0.4f Hz, Ws = %0.4f Hz\n\n", Wp, Ws);


%butterworth LP filter
[N_butter, Wn_butter] = buttord(Wp, Ws, Rp, Rs, 's');
[N_cheby1, Wn_cheby1] = cheb1ord(Wp, Ws, Rp, Rs, 's');
fprintf("Filter order:\nButterworth : %d\nChebyshev Type1 : %d\n", N_butter, N_cheby1);

[B, A] = butter(N_butter, Wn_butter, 's');
[num, den] = lp2hp(B, A, Wp_cap);

omega = 0:20:2*pi*6000;
h_butter = freqs(num, den, omega);
plot(omega/(2*pi), 20*log10(abs(h_butter)), 'g');
xlabel('Frequency in Hz');
ylabel('Gain in dB');
title('Highpass filter');
axis([0 6000 -80 4]);