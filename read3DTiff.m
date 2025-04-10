function [originalImage] = read3DTiff(stackname)
    info = imfinfo(stackname); %extract basic information of the image
    num_images = numel(info); %counts number of z-slices in the image. Same for original and mask
    desc = info.ImageDescription; %Extract string with channel information
       
    %Read in orignal image
    originalImage{num_images} = []; %Create an empty cell array with appropriate dimensions for the images.
   
    parfor zslice = 1:num_images
        originalImage{zslice} = mat2gray(imread(stackname, zslice, 'Info', info));
    end
  
    %Now have cell array with original greyscale image.
end