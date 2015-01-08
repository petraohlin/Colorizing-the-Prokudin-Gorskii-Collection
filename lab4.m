% Lab 4 - TNM087
% Petra Öhlin (petoh078)
% January 2015

%% READ IMAGE
clear all
close all
tic
allImages = imread('Photos/01788v.jpg');

[height, width] = size(allImages);

%% CROPP
%Find the padding on the right side of the image and assume that the
%padding on the other sides are the same.
corner = allImages(1:height*0.1,1:width*0.1);
edgeImage = edge(corner,'canny', 0.01);

[x, y] = find(edgeImage>mean(edgeImage(:)), 1, 'last');
padding = y;

%Cropp the image according to the padding found above. 
height = floor(height/3);
BlueImage = allImages(padding:height-padding,padding:width-padding);
GreenImage = allImages(height+padding:height*2-padding,padding:width-padding);
RedImage = allImages(height*2+padding:height*3-padding,padding:width-padding);


%% ALIGN
%Align the red and blue images to the green channel.

%If the image is big, find how many times (levels) the image must be half
%to become a reasonable size (300 pixels) to find a shift.
level = floor(log2(width/300));

imgOffsetRed = findOffset(RedImage, GreenImage, level);
imgOffsetBlue = findOffset(BlueImage, GreenImage, level);

newRed = circshift(RedImage, imgOffsetRed);
newBlue = circshift(BlueImage, imgOffsetBlue);

%% RECOMBINE, COLORCORRECT AND RESULT
%Recombine the shifted color channels, without color correction. 
rgbImage = cat(3, newRed, GreenImage, newBlue);

%Color correction according to the method "gray world assumption".
%The idea of this method is that the mean of the red, green, and 
%blue color channels should be roughly equal.
averageRed = mean(newRed(:));
averageGreen = mean(GreenImage(:));
averageBlue = mean(newBlue(:));

%If the three channels are equal nothing needs to be done
if averageRed ~= averageGreen && averageRed ~= averageBlue
    a = averageGreen/averageRed;
    b = averageGreen/averageBlue;
    
    newRed = a*newRed;
    newBlue = b*newBlue;
end

%Adjust the contrast in all color channels
newRed = imadjust(newRed);
GreenImage = imadjust(GreenImage);
newBlue = imadjust(newBlue);

%Recombine the shifted color channels, with color correction.
rgbImageColorCorrection = cat(3, newRed, GreenImage, newBlue);


imshowpair(rgbImage, rgbImageColorCorrection, 'montage')
toc


