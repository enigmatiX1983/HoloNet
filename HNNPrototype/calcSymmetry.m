%%Function gives a value for the symmetry of a set of vectors around the
%%complex domain.  The closer to zero, the more symmetric it is
function [ symmetryResults ] = calcSymmetry( matrix )
%CALCSYMMETRY Summary of this function goes here
%   Detailed explanation goes here
    sizeMatrix = size(matrix, 1);
    symmetryResults = zeros(sizeMatrix, 1);
    
    for n = 1:sizeMatrix
        symmetryResults(n,1) = sum(matrix(n,:));
    end

end

