%% Code for the calculation of the Projection Matrix 
cd ~/Documents/ % Folder where the dataset is saved
load Features2D_dataset1.mat %loading the dataset
load Features3D_dataset1.mat
%% we know that f2D = Mf3D therefore we have the following relation in space  
A = zeros(2*37,12);

for i = 1:2*37
    if (rem(i,2) == 1)
    A(i,:) = [f3D(1,ceil(i/2)) f3D(2,ceil(i/2)) f3D(3,ceil(i/2)) 1 0 0 0 0 -f2D(1,ceil(i/2))*f3D(1,ceil(i/2)) ...
        -f2D(1,ceil(i/2))*f3D(2,ceil(i/2)) -f2D(1,ceil(i/2))*f3D(3,ceil(i/2)) -f2D(1,ceil(i/2))];
    end
    if (rem(i,2) == 0)
    A(i,:)  = [ 0 0 0 0 f3D(1,ceil(i/2)) f3D(2,ceil(i/2)) f3D(3,ceil(i/2)) 1 -f2D(2,ceil(i/2))*f3D(1,ceil(i/2)) ...
        -f2D(2,ceil(i/2))*f3D(2,ceil(i/2)) -f2D(2,ceil(i/2))*f3D(3,ceil(i/2)) -f2D(2,ceil(i/2))];
    
    
    
    end
end

m = null(A);
M = zeros(3,4);
for i = 1 :12 
M(ceil(i/4),i - 4*(ceil(i/4)-1)) = m(i);
end

M = M/sqrt(M(3,1)^2 + M(3,2)^2 + M(3,3)^2);

disp(' M = ');
disp(M);
