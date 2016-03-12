%code for video stabilization for translation only model
clear
video = mmread('car_shanky_translation.avi');
n = length(video.frames);
[R,C,depth]=size(video.frames(1).cdata);
%%code for data generation
%made changes in match.m file have a look if there are errors
error = {};
i =1 ;
%t_x = 15;
%t_y = 15;
vid(:,:,i) = rgb2gray(imread('1.jpg'));
for i = 2:n
fprintf('%d frames left.\n', n-i);
error{i} = zeros(11,11);
    for t_x = -5:5
       for t_y = -5:5
            %t_x,t_y
            data_1 = vid(:,:,i-1);
            data_2 = video.frames(i).cdata(:,:,1);%rgb2gray(imread(strcat(int2str(i),'.jpg')));
            imwrite(data_2,'data_2.jpg');
            data_1 = imtranslate(data_1,[t_x,t_y]);
            imwrite(data_1,'data_1.jpg');
            t_data = sum(sum((data_1-data_2).*(data_1-data_2)));
            t_data = t_data/(R*C-count);
           error{i}(t_x+6,t_y+6) = t_data;
       end
    end
    [r,c] = find(error{i}==min(error{i}(:)));
    tx = r-6;
    ty = c-6;
    vid(:,:,i) = imtranslate(video.frames(i-1).cdata(:,:,1),[tx,ty]);
    %vid(:,:,i) = imrotate(vid(:,:,i-1),rot,'bilinear','crop');
    %A = [cosd(rot) -sind(rot) tx ; sind(rot) cosd(rot) ty ; 0 0 1];
end

%%
%{
for i = 2:n
    i
    [r,c] = find(error{i}==min(error{i}(:)));
    tx = r-6;
    ty = c-6;
    for row = 1:R
        for col = 1:C
            row;
            
        j = row - t_x;
        k = col -t_y;
        if ( (0<j && j<(R+1)) && (k>0 && k<(C+1)))
            
        vid(row,col,i) = video.frames(i-1).cdata(j,k,1);%vid(j,k,i-1);
        else
        vid(row,col,i) = 0;
        end    
        end
    end

end
%%
%{
 [R,C,] = size
vid = zeros(R,C,n);
i =1;
vid(:,:,1)= rgb2gray(imread(strcat(int2str(i),'.jpg')));
for  i = 2 :n 
    i
    [r,c] = find(error{i-1}==min(error{i-1}(:)));
    t_x = r-6;
    t_y = c-6;
    for row = 1:R
        for col = 1:C
        j = col - t_x;
        k = row -t_y;
        if ( (0<j && j<(C+1)) && (k>0 && k<(R+1)))
            
        vid(row,col,i) = video.frames(i-1).cdata(k,j,1);
        %1
        else
        vid(row,col,i) = 0;
        end    
        end
    end

%}
%}









