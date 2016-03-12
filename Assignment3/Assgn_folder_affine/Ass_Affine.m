%code for video stabilization for translation only model 
clear
format longe
load affine_data
[R,C,n]= size(vid);
error = {};
i =1 ;
%t_x = 15;
%t_y = 15;
for i = 1:n-1
fprintf('%d frames left.\n', n-i); 
error{i} = zeros(5,5,11,11,11,11);
    for t_x = 0:3
       for t_y = 0:3
           for a11 = 0:0.25:1
               for a12 = 0:0.25:1
                   for a21 = 0 :0.25:1
                       for a22 = 0:0.25:1
            data_1 = vid(:,:,i);
            A = [1+a11 1+a12 ;1+a21 1+a22];
            data_1 = my_affine_warp(data_1,A);
            data_1 = imtranslate(data_1,[t_x,t_y]);
            data_2 = vid(:,:,i+1);
            t_data = sum(sum((data_1-data_2).*(data_1-data_2)));
            error{i}(t_x+1,t_y+1,uint8(4*a11)+1,uint8(4*a12)+1,uint8(4*a21)+1,uint8(4*a22)+1) = t_data;
                       end
                   end
               end
           end
       end
    end
  end
                       
%%
%{
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
%}

