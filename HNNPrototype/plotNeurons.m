function [ output_args ] = plotNeurons( trainedNetwork )
%PLOTNEURONS Summary of this function goes here
%   Detailed explanation goes here
    i = real(trainedNetwork(:,1));
    j = imag(trainedNetwork(:,1));
    
    ij = [i j]

    length = size(ij,1);
    
    plotv([ij(1,:); [0 0]], '-');
    hold on;
    
    for n=2:length
        plotv([ij(n,:); [0 0]], '-');
    end
end

