function [ processedImage ] = simRetina( image )
% Summary of this function goes here
%   Detailed explanation goes here
    onCellMask = [ -1/8 -1/8 -1/8; -1/8 1 -1/8; -1/8 -1/8 -1/8 ];
    offCellMask = [ 1/8 1/8 1/8; 1/8 -1 1/8; 1/8 1/8 1/8 ];
    
    imgSize = size(image);
    processedImage = zeros(imgSize(1), imgSize(2));
    
    for i=2:(imgSize(1)-1)
        for j=2:(imgSize(2)-1)
            processedImage(i+1,j+1) = (image(i-1,j-1)*onCellMask(1,1)) + (image(i-1,j)*onCellMask(1,2)) + (image(i-1,j+1)*onCellMask(1,3)) + (image(i,j-1)*onCellMask(2,1)) + (image(i,j)*onCellMask(2,2)) + (image(i,j+1)*onCellMask(2,3)) + (image(i+1,j-1)*onCellMask(3,1)) + (image(i+1,j)*onCellMask(3,2)) + (image(i+1,j+1)*onCellMask(3,3));
        end
    end
end

