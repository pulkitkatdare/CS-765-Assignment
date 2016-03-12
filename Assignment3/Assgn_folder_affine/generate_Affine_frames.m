for i=1:a.nrFramesTotal     
    imwrite(uint8(vid(:,:,i)),strcat(int2str(i),'.jpg')); 
    
end