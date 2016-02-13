%% This Part of the Code estimates the Data Points and Image Matrix for the Computation...
%For the Sake of Simplicity the Images are incorporated in the sift function file for easier access
% There have been changes made to the matchn function to suit our
% requirement
clear 
format longe
Image2 = imread('goi2_downsampled.jpg');
Image1 = imread('goi1_downsampled.jpg');
[image_2, descriptors2, locs2] = sift('goi2_downsampled.jpg');
[image_1, descriptors1, locs1] = sift('goi1_downsampled.jpg');
[num,match,Rows,Columns]=match('goi1_downsampled.jpg', 'goi2_downsampled.jpg');
%% Computation Part: Here the Homography Matrix is being Computed
%In the 'for' loop below the Matrix A has been generated 'Am = 0' 
%We are considering Rows as our x coordinates and Columns as our y
%coordinate
A = zeros(2*num,9);
for i = 1 : 2*num
   if(rem(i,2) ==1)
   A(i,:) = [-Rows(1,ceil(i/2)) -Columns(1,ceil(i/2)) -1 0 0 0  Rows(2,ceil(i/2))*Rows(1,ceil(i/2)) Rows(2,ceil(i/2))*Columns(1,ceil(i/2)) Rows(2,ceil(i/2))];
   
   else
   A(i,:) = [ 0 0 0 -Rows(1,ceil(i/2)) -Columns(1,ceil(i/2)) -1 Columns(2,ceil(i/2))*Rows(1,ceil(i/2)) Columns(2,ceil(i/2))*Columns(1,ceil(i/2)) Columns(2,ceil(i/2))]; 
   end

end
 %Here the Rank of A comes out to be 9 so the solution we are looking for
 %is the eigen vector corresponding to minimum eigenvalue
[lamb,w] = eig(A'*A);
H=lamb(:,1)/norm(lamb(:,1));
H = H/norm(H);
H = reshape(H,3,3)';
Hinv = inv(H);
Hinv = Hinv/Hinv(3,3);
%% Reverse Warping of the Sample in this part of the Code Here we have Implemented...
% both the Bilinear model as well as the absolute model 
ImageWarped2 = uint8(zeros(360,640));
for x = 1 : 360 
    for y = 1:640
    x_2 = Hinv(1,1)*x + Hinv(1,2)*y + Hinv(1,3)/(Hinv(3,1)*x + Hinv(3,2)*y + Hinv(3,3));
    y_2 = Hinv(2,1)*x + Hinv(2,2)*y + Hinv(2,3)/(Hinv(3,1)*x + Hinv(3,2)*y + Hinv(3,3));
    
    if ((y_2<640 && y_2 > 1) && (x_2< 360 && x_2 > 1))
    xmin = floor(x_2);
    xmax = ceil(x_2);
    ymin = floor(y_2);
    ymax = ceil(y_2);
    %bilinear model
    ImageWarped2(x,y) =  ((Image1(xmin,ymin))*((ymax-y_2)*(xmax-x_2))+Image1(xmax,ymax)*((y_2-ymin)*(x_2-xmin))+Image1(xmax,ymin)*((x_2-xmin)*(ymax-y_2))...
        +Image1(xmin,ymax)*((xmax -x_2)*(y_2-ymin)));
    %Simpler Model Try both of them 
    %ImageWarped2(x,y) = Image1(round(x_2),round(y_2));
    
    end
    end
end
ImageWarped2 = uint8(ImageWarped2);
imwrite(ImageWarped2,'WarpedImage2.jpg');
[Image1 ,map1 ] = imread('goi1_downsampled.jpg');
[Image2 ,map2 ] = imread('WarpedImage2.jpg');
subplot(1,2,1),imshow(Image1);
subplot(1,2,2),imshow(Image2);
%subplot(1,3,3),imshow(Image3);
