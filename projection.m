function [imPixel, imPixelHeight] = projection(allZvalues, start, width)
%PROJECTION Summary of this function goes here
%   Parameter: (allZvalues) - A vector that describes the Z vector of point (ii, jj)
%              (start) - The starting pixel for surface layer
%              (width) - How deep to measure intensity

%   Return: (imPixel) - Intensity of pixel
%           (imPixelHeight) - Height of pixel returned

    Zintissue = allZvalues(~isnan(allZvalues));

%   Set the starting point of projection
    if length(Zintissue) >= start
        Zintissue = Zintissue(start:end);
    else
        Zintissue = [];
    end

    if isempty(Zintissue) %if there are no in-focus values at this position
        imPixel = 0; %assign the pixel to be black (0)
        imPixelHeight = NaN; %and the height to not exist

    % if there are values, take the max intesity value of the first #N pixels that are in-focus
    else
        imPixelHeight = find(~isnan(allZvalues), 1);
        Zlength = length(Zintissue);
        if Zlength >= width
            imPixel = max(Zintissue(1:width));
        else
            imPixel = max(Zintissue(1:Zlength));
        end
    end

