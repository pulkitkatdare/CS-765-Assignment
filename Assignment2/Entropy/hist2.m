function n=hist2(A,B,L) 


ma=0; 
MA=255; 
mb=0; 
MB=255;

% For sensorimotor variables, in [-pi,pi] 
% ma=-pi; 
% MA=pi; 
% mb=-pi; 
% MB=pi;

% Scale and round to fit in {0,...,L-1} 
A=round((A-ma)*(L-1)/(MA-ma)); 
B=round((B-mb)*(L-1)/(MB-mb)); 
n=zeros(L); 
x=0:L-1; 
for i=0:L-1 
    n(i+1,:) = histc(B(A==i),x,1); 
end
end