%% Code for the calculation of the Projection Matrix 
cd ~/Documents/ % Folder where the dataset is saved
load Features2D_dataset2.mat %loading the dataset
load Features3D_dataset2.mat
%% we know that f2D = Mf3D therefore we have the following relation in space  
format longe
[ m n] = size(f3D);
A = zeros(2*n,12);

for i = 1:2*n
    if (rem(i,2) == 1)
    A(i,:) = [f3D(1,ceil(i/2)) f3D(2,ceil(i/2)) f3D(3,ceil(i/2)) 1 0 0 0 0 -f2D(1,ceil(i/2))*f3D(1,ceil(i/2)) ...
        -f2D(1,ceil(i/2))*f3D(2,ceil(i/2)) -f2D(1,ceil(i/2))*f3D(3,ceil(i/2)) -f2D(1,ceil(i/2))];
    end
    if (rem(i,2) == 0)
    A(i,:)  = [ 0 0 0 0 f3D(1,ceil(i/2)) f3D(2,ceil(i/2)) f3D(3,ceil(i/2)) 1 -f2D(2,ceil(i/2))*f3D(1,ceil(i/2)) ...
        -f2D(2,ceil(i/2))*f3D(2,ceil(i/2)) -f2D(2,ceil(i/2))*f3D(3,ceil(i/2)) -f2D(2,ceil(i/2))];
    
    
    
    end
end

if (rank(A) ~= 12)
    m = null(A);
else 
     k = eig(A'*A);
     m = null(A'*A-k(1)*eye(12,12));


end
%m = null(A);
M = zeros(3,4);
for i = 1 :12 
M(ceil(i/4),i - 4*(ceil(i/4)-1)) = m(i);
end

M = M/sqrt(M(3,1)^2 + M(3,2)^2 + M(3,3)^2);

disp('M = ');
disp(M);
