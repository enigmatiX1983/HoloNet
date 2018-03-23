function [ symmetryResults ] = calcSymmetry( matrix )
%CALCSYMMETRY Summary of this function goes here
%   Detailed explanation goes here
    sizeMatrix = size(matrix, 1);
    symmetryResults = zeros(sizeMatrix, 1);
    
    for n = 1:sizeMatrix
        symmetryResults(n,1) = sum(matrix(n,:));
    end

end

