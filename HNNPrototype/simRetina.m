function [ processedImageColorUint ] = simRetina( imageUint )
%Convert to floating point single
    %yCbCrImg = rgb2ycbcr(image);
    
% Summary of this function goes here
%   Detailed explanation goes here
    onCenterCellMask = [ -1 -1 -1; 
                         -1  8 -1; 
                         -1 -1 -1 ];
    offCenterCellMask = [ 1  1  1; 
                          1 -8  1; 
                          1  1  1];
    
    imgSize = size(imageUint);
    imgDimension = size(size(imageUint));
    
    %If image is RGB, quick and dirty average method for edges
    if imgDimension(2) == 3
        tmpImage = single(imageUint);
        image = (tmpImage(:,:,1) + tmpImage(:,:,2) + tmpImage(:,:,3) / 3);
    else
        image = single(imageUint);
    end
    processedImageOn = ones(imgSize(1), imgSize(2))*255;
    processedImageOff = ones(imgSize(1), imgSize(2))*255;
        
    for i=2:(imgSize(1)-1)
        for j=2:(imgSize(2)-1)
            processedImageOn(i+1,j+1) = (image(i-1,j-1)*onCenterCellMask(1,1)) + (image(i-1,j)*onCenterCellMask(1,2)) + (image(i-1,j+1)*onCenterCellMask(1,3)) + (image(i,j-1)*onCenterCellMask(2,1)) + (image(i,j)*onCenterCellMask(2,2)) + (image(i,j+1)*onCenterCellMask(2,3)) + (image(i+1,j-1)*onCenterCellMask(3,1)) + (image(i+1,j)*onCenterCellMask(3,2)) + (image(i+1,j+1)*onCenterCellMask(3,3));
            processedImageOff(i+1,j+1) = (image(i-1,j-1)*offCenterCellMask(1,1)) + (image(i-1,j)*offCenterCellMask(1,2)) + (image(i-1,j+1)*offCenterCellMask(1,3)) + (image(i,j-1)*offCenterCellMask(2,1)) + (image(i,j)*offCenterCellMask(2,2)) + (image(i,j+1)*offCenterCellMask(2,3)) + (image(i+1,j-1)*offCenterCellMask(3,1)) + (image(i+1,j)*offCenterCellMask(3,2)) + (image(i+1,j+1)*offCenterCellMask(3,3));
        end
    end
    
    %Convert to RGB
    processedImageColor = ones(imgSize(1), imgSize(2), 3);
    processedImageColor(:, :, 1) = processedImageOn;
    processedImageColor(:, :, 2) = processedImageOff;
    
    processedImageColorUint = uint8(processedImageColor);
    imshow(processedImageColorUint)
end

