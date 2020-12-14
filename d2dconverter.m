function [num, den] = d2dconverter(B, A, wc1, wc2)
  %Created by Arunabh Kashyap
  lambda = sin((wc1-wc2)/2)/sin((wc1+wc2)/2);
  fprintf("lambda = %0.4f\n", lambda);
  [num, den] = iirlp2lp(B, A, wc1, wc2);
end
