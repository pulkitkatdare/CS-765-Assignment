clear 
barbara = double(imread('barbara.png'));
negative_barbara = (imread('negative_barbara.png'));
negative_barbara = imrotate(negative_barbara,28.5,'crop');
negative_barbara = double(imtranslate(negative_barbara,[-2,0]));
negative_barbara = double(negative_barbara) +  (10*randn(size(barbara)));
imshow(uint8(negative_barbara));
negative_barbara = double(negative_barbara);
%% Data Acquisition till now the main code starts from now. 
%%%%We have made use of A Function which computes the joint histogram
%%%%between two images
[m p] = size(barbara);
negative_barbara = uint8(negative_barbara);
negative_barbara = double(negative_barbara);
Shannon_entropy = zeros(25,121);

for t_x = -12 : 12
    New_image = imtranslate(negative_barbara,[t_x,0]);
    t_x
    for theta = -60:60
       
        
    Rotate_image = imrotate(New_image,theta,'crop');
    joint_histogram = hist2(barbara,Rotate_image,26)/(m*p);
    n = joint_histogram(joint_histogram ~=0);
    q = log(n);
    
    Shannon_entropy(t_x+13,theta+61) = -n'*q ;
    
    end
end

[R,C] = find(Shannon_entropy ==min(Shannon_entropy(:)));
figure;
surf(Shannon_entropy);
new_image = imrotate(negative_barbara,C-61,'crop');
new_image = imtranslate(new_image,[R-13,0]);
figure;
subplot(1,2,1),imshow(uint8(barbara));
subplot(1,2,2),imshow(uint8(new_image));

