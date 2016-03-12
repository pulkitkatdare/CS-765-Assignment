%code for video stabilization for translation only model 
clear
video = mmread('car_shanky_translation.avi');
n = length(video.frames);
%%
 %numFrames = video.NumberOfFrames;
 %n=numFrames;
 %for i = 1:n
 %frames = read(video,i);
 %imwrite(frames,['cars_frames/Image' int2str(i), '.jpg']);
 %im(i)=image(frames);
 %end
%generate data for sift detector
for i = 1:n
%frame_data = rgb2gray(video.frames(i).cdata);
%frames = read(video,i);
imwrite(video.frames(i).cdata,strcat('cars_frames/',num2str(i),'.jpg'));
end
%%%
%%for i = 1:n-1
%%%[num,match,Rows, Columns] = match(strcat('cars_frames/',num2str(i),'.jpeg'), strcat('cars_frames/',num2str(i+1),'.jpeg'));
%%%end




