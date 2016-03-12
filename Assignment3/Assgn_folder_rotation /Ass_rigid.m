clear 
load rigid_data
%code for video stabilization for translation only model
[R,C,depth]=size(vid);
n = depth;
error = {};

i =1 ;
vid_stable(:,:,i) = vid(:,:,1);
for i = 2:n
fprintf('%d frames left.\n', n-i);
error{i} = zeros(11,11,7);
    for t_x = -5:5
       for t_y = -5:5
           for theta = -3:3
            %t_x,t_y
            data_1 = vid_stable(:,:,i-1);
            data_2 = vid(:,:,i);
            data_1 = imtranslate(data_1,[t_x,t_y]);
            data_1 = imrotate(data_1,theta,'bilinear','crop');
            count = 0 ;
            for l = 1:R
                for m = 1:C
                if(data_1(l,m) == 0)
                data_2(l,m)=0;
                count = count +1;
                end
                end
            end
           
            t_data = sum(sum((data_1-data_2).*(data_1-data_2)));
            t_data = t_data/(R*C-count);
           error{i}(t_x+6,t_y+6,theta+4) = t_data;
           end
       end
    end
    [r,c,angle] = find(error{i}==min(error{i}(:)));
    tx = r-6;
    ty = c-6;
    rot = angle-4;
    vid_stable(:,:,i) = imtranslate(vid(:,:,i-1),[tx,ty]);
    vid_stable(:,:,i) = imrotate(vid(:,:,i-1),rot,'bilinear','crop');
    A = [cosd(rot) -sind(rot) tx ; sind(rot) cosd(rot) ty ; 0 0 1];
    
end
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










