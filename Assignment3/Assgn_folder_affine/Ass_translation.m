%code for video stabilization for translation only model 
clear
video = mmread('car_shanky_translation.avi');
n = length(video.frames);
%%code for data generation
%made changes in match.m file have a look if there are errors
error = {};
i =1 ;
%t_x = 15;
%t_y = 15;
for i = 1:n-1
fprintf('%d frames left.\n', n-i);
error{i} = zeros(11,11);
    for t_x = -5:5
       for t_y = -5:5
            %t_x,t_y
            data_1 = rgb2gray(imread(strcat(int2str(i),'.jpg')));
            data_2 = rgb2gray(imread(strcat(int2str(i+1),'.jpg')));
            imwrite(data_2,'data_2.jpg');
            data_1 = imtranslate(data_1,[t_x,t_y]);
            imwrite(data_1,'data_1.jpg');
            t_data = sum(sum((data_1-data_2).*(data_1-data_2)));
           %[num,match,Rows, Columns] = match('data_1.jpg', 'data_2.jpg');
           %if(num ~= 0 )
            %    n = length(Rows);
             %   error = (1/n)*((Rows(1,:)-Rows(2,:))*(Rows(1,:)-Rows(2,:))' +(Columns(1,:)-Columns(2,:))*(Columns(1,:)-Columns(2,:))' );
           %else
            %    error = inf;
           %end
           error{i}(t_x+6,t_y+6) = t_data;
           %clear num
           %clear match 
           %clear Rows
           %clear Columns
       end
    end
end
%%
[R,C,depth] = size(video.frames(1).cdata);
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








end



