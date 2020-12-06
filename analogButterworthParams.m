function [num, den] = analogButterworthParams(Wp, Ws, Rp, Rs)

    fp = Wp/(2*pi); %passband frequency in Hz
    fs = Ws/(2*pi); %stopband frequency in Hz
    [N, Wn] = buttord(Wp, Ws, Rp, Rs, 's'); %order
  
    chi2 = (1/(10^(-Rp/10))) - 1; %using negative Rp and Rs to ensure attenuation
    A2 = 1/(10^(-Rs/10));
    chi = sqrt(chi2);
    A = sqrt(A2);
    
    Wc1 = Wp/(chi^(1/N));
    Wc2 = Ws/((A2 - 1)^(1/(2*N)));
    
    %*************************IMPORTANT********************************
    %by default Wn matches stopband attenuation
    %Uncomment the below line in order to match the passband attenuation
    Wn = Wc1; fprintf("\nUSING PASSBAND SPECS FOR CUTOFF\n");
    fn = Wn/(2*pi);
    
    k = Wp/Ws; %transition ratio or selectivity parameter
    k1 = chi/sqrt(A^2 - 1); %discrimination parameter

    Ncalc = log10(1/k1)/log10(1/k) ;
    
    fprintf("fp = %0.4f Hz, fs = %0.4f Hz, Rp = %0.0f dB, Rs = %0.0f dB\n\nN = %d, cutoff = %0.4f rad/s or %0.4f Hz\n",fp, fs, Rp, Rs, N, Wn, fn);
    fprintf("chi2 = %0.4f, A2 = %0.4f\nchi = %0.4f, A = %0.4f\n\n",chi2, A2, chi, A);
    fprintf("k = %0.4f, k1 = %0.4f\n1/k = %0.4f, 1/k1 = %0.4f\nNcalc = %0.4f\n", k, k1, 1/k, 1/k1, Ncalc);
    
    [num,den] = butter(N, Wn,'s');
