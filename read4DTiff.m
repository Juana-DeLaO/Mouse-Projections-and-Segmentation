function [originalImage] = read4DTiff(stackname)
    info = imfinfo(stackname); %extract basic information of the image
    num_images = numel(info); %counts number of z-slices in the image. Same for original and mask
    desc = info.ImageDescription; %Extract string with channel information
    [a,b] = regexp(desc, 'channels=\d*\n'); %Searches the string for the number of channels. 

    if a ~= 0 && b ~= 0 %Check if there is a channel value. 
        chanNum = str2double(desc(a+9:b-1)); %If it exists, pulls out the channel number using the index and turns it into a double.
    else
        chanNum = 1; %If not, then there's just one channel
    end
    

    originalImage{chanNum, num_images/chanNum} = []; %Create an empty cell array with appropriate dimensions for the images.
    %Does some math to separate outz-slices by channel. Uses "info" to find the right slice faster, reads it in, 
    %and then converts to grayscale.
    parfor k = 1:num_images
            originalImage{k} = mat2gray(imread(stackname, k, 'Info', info));
    end
    %Now have cell array with original greyscale image.
end