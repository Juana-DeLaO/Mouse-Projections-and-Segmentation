function [newImage] = test_read4DTiff(stackname)
    t = Tiff(stackname);
    num = getTag(t, "ImageDescription");
    class(num);
    chanNum = str2double(regexp(num, "(?<=channels=)\d+", "match"));
    slices = str2double(regexp(num, "(?<=slices=)\d+", "match"));
    if chanNum
        newImage{chanNum, slices} = [];
    else
        newImage{1, slices} = [];
    end
        
    parfor zslice = 1:slices
        for channel = 1:chanNum
                t.setDirectory(chanNum*(zslice-1) + channel)
                newImage{channel, zslice} = mat2gray(t.read());
                if t.lastDirectory
                    break
                end
                t.nextDirectory;
        end
    end
end

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
    
    %chanName{chanNum} = [];
    %for channel = 1:chanNum
    %    prompt = "What is stained in Channel " + num2str(channel) + "?";
    %    chanName{channel} = inputdlg(prompt,"Channel Stains",'s');
    %end

    %Read in orignal image
    originalImage{chanNum, num_images/chanNum} = []; %Create an empty cell array with appropriate dimensions for the images.
    %Does some math to separate outz-slices by channel. Uses "info" to find the right slice faster, reads it in, 
    %and then converts to grayscale.
    for channel = 1:chanNum
        for zslice = 1:num_images/chanNum
            originalImage{channel,zslice} = mat2gray(imread(stackname, chanNum*(zslice-1) + channel, 'Info', info));
        end
    end
    %Now have cell array with original greyscale image.
end