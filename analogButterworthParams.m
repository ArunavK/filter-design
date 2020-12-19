function [num, den] = analogButterworthParams(Wp, Ws, Rp, Rs)
    %Created by Arunabh Kashyap
    
    [N, Wn] = buttord(Wp, Ws, Rp, Rs, 's'); %order
  
    chi2 = (1/(10^(-Rp/10))) - 1; %using negative Rp and Rs to ensure attenuation
    A2 = 1/(10^(-Rs/10));
    chi = sqrt(chi2);
    A = sqrt(A2);
    
    Wc1 = Wp/(chi^(1/N)); %using passband specs
    Wc2 = Ws/((A2 - 1)^(1/(2*N))); %stopband specs
    
    %*************************IMPORTANT********************************
    %by default Wn matches stopband attenuation
    %Uncomment the below line in order to match the passband attenuation
    
%     Wn = Wc1; fprintf("\nUSING PASSBAND SPECS FOR CUTOFF\n");
    
    %******************************************************************

    
    k = Wp/Ws; %transition ratio or selectivity parameter
    k1 = chi/sqrt(A^2 - 1); %discrimination parameter

    Ncalc = log10(1/k1)/log10(1/k) ;
    
    fprintf("Wp = %0.4f rad/s, Rp = %0.2f dB,\nWs = %0.4f rad/s, Rs = %0.2f dB\n", Wp, Rp, Ws, Rs);
    fprintf("\nN = %d, cutoff = %0.4f rad/s\n", N, Wn);
    fprintf("chi2 = %0.4f, A2 = %0.4f\nchi = %0.4f, A = %0.4f\n",chi2, A2, chi, A);
    fprintf("k = %0.4f, k1 = %0.4f\n1/k = %0.4f, 1/k1 = %0.4f\nNcalc = %0.4f\n", k, k1, 1/k, 1/k1, Ncalc);
    
    [num,den] = butter(N, Wn,'s');
