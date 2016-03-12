%code for video stabilization for translation only model 
clear
video = mmread('car_shanky_translation.avi');
n = length(video.frames);
%%code for data generation
for i = 1:n
frame_data = rgb2gray(video.frames(i).cdata);
imwrite(video.frames(i).cdata,strcat('cars_frames/',num2str(i),'.jpg'));
end



