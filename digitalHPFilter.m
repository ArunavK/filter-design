clc;
clear;

tic;
Fs = 2000;
fp = 700;
fs = 500;
Rp = 1;
Rs = 32;

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
B(B < 1e-8) = 0;
A(A < 1e-8) = 0;
Hlp = tf(B, A);
display(Hlp);
fprintf("====================================================================");

%Step 4
fprintf("\nStep 4: Convert LP Prototype specs to Desired Filter Specs\n");
[num, den] = lp2hp(B, A, Wpc);
den(den < 1e-8) = 0;
num(num < 1e-8) = 0;
Hhp = tf(num, den);
display(Hhp);
fprintf("====================================================================");

%Step 5
fprintf("\nStep 5: Convert analog filter specs to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
fprintf("CAUTION: Use z in place of s, now that you're in the digital domain\n");
Gd = tf(numd, dend, 0.5);
display(Gd);

fprintf("\n*********************************\n");
toc;
fprintf("*********************************\n");
