function segVis(segmentation, outlines, measurement, colorScheme, textColor, fontSize, range, title)
    segIm = segmentation.*outlines; %multiply the segmentation with the outline to remove the junction
    segIm(segIm == 0) = NaN; %Reassign all zero values as NaN. This will keep the outlines from being inlcuded in the color map scale
    mask = isnan(segIm); %Pull out all the background/outlines from the image
    graymask = 0.001*mask; %Dim the values of the background
    graymask = repmat(graymask,1,1,3); %Create a multilayer mask to layer over data image

    %Assign each of the measurements values to the areas of the image that have the same cell index
    for i = 1:length(measurement)
        segIm(segIm == i) = measurement(i);
    end

    imshow(segIm); %Create and image of the segmentation
    colormap(colorScheme); %Add the desired colormap to the image
    colorbar %include the color bar in the figure
    c = colorbar; % define the colorbar as a variable
    c.Color = textColor; %Change the colorbar text color
    c.FontSize = fontSize; %Adjust the colorbar text size
    set(gca, "CLim", range) %Define the colorbar lower and upper limits
    
    hold on %Overlay the mask of the background/outlines
    h = imshow(graymask);
    hold off
    h.AlphaData = mask; %make parts of the mask transparent
    fig = gca; %Assign the current visual as a figure
    fig.Title.String = title; %Give the figure a title
    fig.XColor = textColor; %Change the color of the figures x-axis
    fig.YColor = textColor; %Change the color of the figure of the y-axis
    fig.Color = textColor; %Change the color of the figure text
    
end