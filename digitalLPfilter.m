clc;
clear;

tic;
wp = 0.25*pi; %normalised passband frequency in rad/s
ws = 0.55*pi; %normalised stopband frequency in rad/s
Rp = 0.5; %passband attenuation in dB
Rs = 15; %stopband attenuaiton in dB

%given frequencies are already normalised

% Step 1: Prewarping
fprintf("\nStep 1: Prewarping\n");
[Wpc, Wsc] = prewarp(wp, ws);
fprintf("====================================================================");

%Step 2: LP prototype
fprintf("\nStep 2: LP prototype specs\n");
fprintf("Not needed cause already in LP\n");
Wp = Wpc;
Ws = Wsc;
fprintf("====================================================================");

%Step 3:Analog LP Prototype filter design
fprintf("\nStep 3: Analog LP Prototype filter design\n");
fprintf("Butterworth filter design:\n");
[B, A] = analogButterworthParams(Wp, Ws, Rp, Rs); %CAREFUL: ensure passband or stopband specs in the file
B(abs(B) < 1e-6) = 0;
A(abs(A) < 1e-6) = 0;
fprintf("====================================================================");

%Step 4
fprintf("\nStep 4: Convert LP Prototype to Desired Filter\n");
fprintf("Not needed because already in LP");
num = B; den = A;
Hd = tf(num, den);
display(Hd);
% display(num);
% display(den);
fprintf("====================================================================");

%Step 5
fprintf("\nStep 5: Convert analog filter to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
numd(abs(numd) < 1e-6) = 0;
dend(abs(dend) < 1e-6) = 0;
fprintf("CAUTION: Use z in place of s, now that you're in the digital domain\n");
Gd = tf(numd, dend, 0.5);
display(Gd);

[z, p, k] = tf2zpk(numd, dend);
fprintf("Zeros:\n");
disp(z);
fprintf("Poles:\n");
disp(p);
fprintf("Gain:\n");
disp(k);

fprintf("*********************************\n");
toc;
fprintf("*********************************\n");
