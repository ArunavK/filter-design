%Created by Arunabh Kashyap

clc;
clear;

%desired filter specs
Wp1c = 2*pi*4000; % Lower passband
Wp2c = 2*pi*7000; % Upper passband
Ws1c = 2*pi*3000; % Lower stopband
Ws2c = 2*pi*8000; % Upper stopband
Rp = 1; % Passband attenuation
Rs = 22; % Stopband attenuation

%geometric symmetry
if(Wp1c*Wp2c > Ws1c*Ws2c)
%     Wp1c = Ws1c*Ws2c/Wp2c;
    Ws1c = Wp1c*Wp2c/Ws2c;    
end
if (Wp1c*Wp2c < Ws1c*Ws2c)
    Wp2c = Ws1c*Ws2c/Wp1c;
%     Ws2c = Wp1c * Wp2c / Ws1c;
end

%parameters of desired fiter
B = Wp2c - Wp1c;
W0c = sqrt(Wp1c*Wp2c);

fprintf("desired filter specs:\nWs1 = %0.0f Hz, Wp1 = %0.0f Hz, Wp2 = %0.0f Hz, Ws2 = %0.0f Hz\n", Ws1c/(2*pi), Wp1c/(2*pi), Wp2c/(2*pi), Ws2c/(2*pi));
fprintf("Bandwidth = %0.0f Hz, Center frequency = %0.0f Hz\n", B/(2*pi), W0c/(2*pi));

% LP prototype specs
Wp = 1;
Ws = (Wp*(W0c^2 - [Ws1c Ws2c].^2)/B)./[Ws1c Ws2c];
fprintf("LP prototype specs:\nWp = 1, Ws = %f, %f\n", Ws(1), Ws(2));
Ws = abs(Ws(1));

fprintf("\nButterworth filter parameters:\n");
[B_butter, A_butter] = analogButterworthParams(Wp, Ws, Rp, Rs);

fprintf("\nChebyshev Type1 filter parameters:\n");
[B_cheby, A_cheby] = analogCheby1Params(Wp, Ws, Rp, Rs);

fprintf("\nElliptic filter parameters:\n");
[N_ellip, Wn_ellip] = ellipord(Wp, Ws, Rp, Rs, 's');
fprintf("N = %d, cutoff = %0.4f Hz\n", N_ellip, Wn_ellip/(2*pi));
[B_ellip, A_ellip] = ellip(N_ellip, Rp, Rs, Wn_ellip, 's');

% fprintf("\nBP Elliptic filter design:\n");
% [num, den] = lp2bp(B_ellip, A_ellip, W0c, B);
% display(num);
% display(den);

%plotting
% omega = 0:20:1.5*Ws2c;
% h = freqs(num, den, omega);
% plot(omega/(2*pi), 20*log10(abs(h)), 'g');
% xlabel('frequency in Hz');
% ylabel('Gain in dB');