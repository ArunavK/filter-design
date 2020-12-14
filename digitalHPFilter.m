%Created by Arunabh Kashyap

clc;
clear;

tic;
Fs = 3200;
fp = 1100;
fs = 700;
Rp = 3;
Rs = 50;

%normalising the frequencies
wp = 2*pi*fp/Fs;
ws = 2*pi*fs/Fs;

% Step 1: Prewarping
fprintf("\nStep 1: Prewarping\n");
[Wpc, Wsc] = prewarp(wp, ws);
fprintf("====================================================================");

%Step 2: LP prototype
fprintf("\nStep 2: LP prototype specs\n");
Wp = 1;
Ws = Wp*Wpc/Wsc;
fprintf("Wp = %0.4f rad/s, Ws = %0.4f rad/s\n", Wp, Ws);
fprintf("====================================================================");

%Step 3:Analog LP Prototype filter design
fprintf("\nStep 3: Analog LP Prototype filter design\n");
fprintf("Chebyshev Type-1 filter design:\n");
[B, A] = analogCheby1Params(Wp, Ws, Rp, Rs);
B(abs(B) < 1e-6) = 0;
A(abs(A) < 1e-6) = 0;
Hlp = tf(B, A);
display(Hlp);
fprintf("====================================================================");

%Step 4
fprintf("\nStep 4: Convert LP Prototype specs to Desired Filter Specs\n");
[num, den] = lp2hp(B, A, Wpc);
den(abs(den) < 1e-6) = 0;
num(abs(num) < 1e-6) = 0;
Hhp = tf(num, den);
display(Hhp);
fprintf("====================================================================");

%Step 5
fprintf("\nStep 5: Convert analog filter specs to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
fprintf("CAUTION: Use z in place of s, now that you're in the digital domain\n");
numd(abs(numd) < 1e-6) = 0;
dend(abs(dend) < 1e-6) = 0;
Gd = filt(numd, dend, 0.5);
display(Gd);

[z, p, k] = tf2zpk(numd, dend);
fprintf("Zeros:\n");
disp(z);
fprintf("Poles:\n");
disp(p);
fprintf("Gain:\n");
disp(k);

fprintf("\n*********************************\n");
toc;
fprintf("*********************************\n");
