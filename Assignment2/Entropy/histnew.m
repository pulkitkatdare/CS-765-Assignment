function n = histnew( A,B)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A=round((A)*(9)/(255)); 
B=round((B)*(9)/(255));
n = zeros(10);
x = 0 : 9;
for i  = 0 :9
 n(i+1,:) = histc(B(A==i),x,1); 

end



end

