clc;
clear;
close all;

%wp = 0.15pi;
%ws = 0.2pi;
%normalised freq = 2*pi*f/fs = 0.15pi; Therefore f = 3600;
delta_p = 0.002;
delta_s = 0.001;

fp = 3600; %passband
fs = 4800; %stopband

[N, fo, mo, w] = firpmord([fp fs], [1 0], [delta_p delta_s], 48000);
display("N = " + N);
figure(1);
b = firpm(N, fo, mo, w);
freqz(b, 1, 1024, 48000);

fprintf("After using computationally efficient design the order should reduce\n");

[N, fo, mo, w] = firpmord([14400 19200], [1 0], [0.001 0.001], 48000);
display("shaping filter N = " + N);
figure(2);
b = firpm(N, fo, mo, w);
freqz(b, 1, 1024, 48000);

[N, fo, mo, w] = firpmord([3600 7200], [1 0], [0.001 0.001], 48000);
display("Interpolator N = " + N);
figure(3);
b = firpm(N, fo, mo, w);
freqz(b, 1, 1024, 48000);

