clc;
clear;

tic;
Rp = 3;
Rs = 15;
fp1 = 200;
fp2 = 300;
fs1 = 50;
fs2 = 450;
Fs = 1000;
% wp1 = 0.45*pi;
% wp2 = 0.65*pi;
% ws1 = 0.3*pi;
% ws2 = 0.75*pi;

wp1 = 2*pi*fp1/Fs;
wp2 = 2*pi*fp2/Fs;
ws1 = 2*pi*fs1/Fs;
ws2 = 2*pi*fs2/Fs;

% Step 1: Prewarping
fprintf("\nStep 1: Prewarping\n");
[Wpc1, Wsc1] = prewarp(wp1, ws1);
[Wpc2, Wsc2] = prewarp(wp2, ws2);
fprintf("====================================================================");

%Step 2: LP prototype specs
fprintf("\nStep 2: LP prototype specs\n");
%ensuring geometric symmetry
fprintf("Wpc1*Wpc2 = %0.4f, Wsc1*Wsc2 = %0.4f\n", Wpc1*Wpc2, Wsc1*Wsc2);
if(Wpc1*Wpc2 - Wsc1*Wsc2 > 1e-5)
%     Wp1c = Ws1c*Ws2c/Wp2c;
    fprintf("Wpc1*Wpc2 > Wsc1*Wsc2\nAdjusting Wsc1...\n");
    Wsc1 = Wpc1*Wpc2 / Wsc2;
    fprintf("new Wsc1 = %0.4f rad/s\n", Wsc1);
elseif (1e-5 < Wsc1*Wsc2 - Wpc1*Wpc2)
%     Wp2c = Ws1c*Ws2c/Wp1c;
    fprintf("Wpc1*Wpc2 < Wsc1*Wsc2\nAdjusting Wsc2...\n");
    Wsc2 = Wpc1*Wpc2/Wsc1;
    fprintf("new Wsc2 = %0.4f rad/s\n", Wsc2);
else
    fprintf("Wpc1*Wpc2 = Wsc1*Wsc2, No adjustment required.\n");
end
BW = Wpc2 - Wpc1;
Wc0 = sqrt(Wpc1*Wpc2);
fprintf("Desired analog filter specs\n");
fprintf("Wsc1 = %0.4f rad/s, Wpc1 = %0.4f rad/s\nWpc2 = %0.4f rad/s, Wsc2 = %0.4f rad/s\n", Wsc1, Wpc1, Wpc2, Wsc2);
fprintf("Bandwidth = %0.4f rad/s, center freq = %0.4f rad/s\n", BW, Wc0);
%calculating LP specs
Wp = 1;
Ws = abs((Wp*(Wc0^2 - Wsc1^2)/BW)./Wsc1);
fprintf("LP prototype specs:\nWp = 1, Ws = %0.4f\n", Ws);
fprintf("====================================================================");

%Step 3:Analog LP Prototype filter design
fprintf("\nStep 3: Analog LP Prototype filter design\n");
fprintf("Butterworth filter design:\n");
[B, A] = analogButterworthParams(Wp, Ws, Rp, Rs);
B(abs(B) < 1e-6) = 0;
A(abs(A) < 1e-6) = 0;
Hlp = tf(B, A);
display(Hlp);
fprintf("====================================================================");

%Step 4
fprintf("\nStep 4: Convert LP Prototype to Desired BP Filter \n");
[num, den] = lp2bp(B, A, Wc0, BW);
den(abs(den) < 1e-6) = 0;
num(abs(num) < 1e-6) = 0;
Hbp = tf(num, den);
display(Hbp);
fprintf("====================================================================");

%Step 5
fprintf("\nStep 5: Convert analog filter specs to digital\n");
[numd, dend] = bilinear(num, den, 0.5); %fs is taken as 0.5 since we always assume T = 2 for simplicity
fprintf("CAUTION: Use z in place of s\n");
numd(abs(numd) < 1e-6) = 0;
dend(abs(dend) < 1e-6) = 0;
Gd = tf(numd, dend, 0.5);
display(Gd);


fprintf("\n*********************************\n");
toc;
fprintf("*********************************\n");
