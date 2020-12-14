function [h] = frequencySampling(H, N)
    %Created by Arunabh Kashyap
    tic;
    H = H';
    n = 0:N-1;
    summation = zeros(1, N);
    if mod(N, 2) == 0
        
        alpha = N/2 - 1;
        for k=1:alpha
            summation = summation + 2*abs(H(k+1))*cos(2*pi*k*(n-alpha)/N);
        end
        h = (1/N) * (H(0+1) + summation);
    else
        
        alpha = (N-1) / 2;
        for k=1:alpha
            summation = summation + 2*abs(H(k+1))*cos(2*pi*k*(n-alpha)/N);
        end
        h = (1/N) * (H(0+1) + summation);
        
    end
    fprintf("\n**************************************\n");
    toc;
    fprintf("\n**************************************\n");
end

