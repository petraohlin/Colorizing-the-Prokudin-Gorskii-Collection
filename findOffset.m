function [ imageOffset ] = findOffset( firstImage, secondImage, level )
%PYRAMIDSHIFT Find the offset between two images. If an image is big, the
%offset is found by a smaller version of the image.

%Resize the image to find the shift faster
firstImage = imresize(firstImage, 0.5^level);
secondImage = imresize(secondImage, 0.5^level);

%Find the offset of the smaller image
firstOffset = offset(firstImage, secondImage);
%Multiply the offset by the differense in size
imageOffset = firstOffset*2^level;

end

