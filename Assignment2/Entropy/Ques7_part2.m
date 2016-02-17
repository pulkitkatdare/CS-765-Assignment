clear 
flash = imread('flash.jpg');
flash = double(rgb2gray(flash));
noflash= imread('noflash.jpg');
noflash = double(rgb2gray(noflash));
noflash = imrotate(noflash,28.5,'crop');
noflash = double(imtranslate(noflash,[-2,0]));
noflash = double(noflash) +  (10*randn(size(noflash)));
imshow(uint8(noflash));
noflash = double(noflash);
%% Data Acquisition till now the main code starts from now. 
%%%%We have made use of A Function which computes the joint histogram
%%%%between two images
[m p] = size(flash);
noflash = uint8(noflash);
noflash = double(noflash);
Shannon_entropy = zeros(25,121);

for t_x = -12 : 12
    New_image = imtranslate(noflash,[t_x,0]);
    t_x
    for theta = -60:60
       
        
    Rotate_image = imrotate(New_image,theta,'crop');
    joint_histogram = hist2(flash,Rotate_image,26)/(m*p);
    n = joint_histogram(joint_histogram ~=0);
    q = log(n);
    
    Shannon_entropy(t_x+13,theta+61) = -n'*q ;
    
    end
end

[R,C] = find(Shannon_entropy ==min(Shannon_entropy(:)));
figure;
surf(Shannon_entropy);
new_image = imrotate(noflash,C-61,'crop');
new_image = imtranslate(new_image,[R-13,0]);
figure;
subplot(1,2,1),imshow(uint8(flash));
subplot(1,2,2),imshow(uint8(new_image));

