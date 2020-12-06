clc;
clear;

wp = 0.25*pi; %passband frequency in rad/s
ws = 0.55*pi; %stopband frequency in rad/s
Rp = 0.5; %passband attenuation in dB
Rs = 15; %stopband attenuaiton in dB

% Step 1: Prewarping
fprintf("\nStep 1: Prewarping\n");
[Wp, Ws] = prewarp(wp, ws);
fprintf("\n");

%Step 2: LP prototype
fprintf("\nStep 2: LP prototype specs\n");
fprintf("Not needed cause already in LP\n");

%Step 3:Analog LP Prototype filter design
fprintf("\nStep 3: Analog LP Prototype filter design\n");
fprintf("Butterworth filter design:\n");
[B, A] = analogButterworthParams(Wp, Ws, Rp, Rs); %CAREFUL: ensure passband or stopband specs in the file

%Step 4
fprintf("\nStep 4: Convert LP Prototype specs to Desired Filter Specs\n");
fprintf("Not needed because already in LP");
num = B; den = A;
Hd = tf(num, den);
display(Hd);
% display(num);
% display(den);

%Step4
fprintf("\nStep 5: Convert analog filter specs to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
fprintf("CAUTION: Use z in place of s, now that you're in the digital domain\n");
Gd = tf(numd, dend, 0.5);
display(Gd);
