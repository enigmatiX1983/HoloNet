function [ output_args ] = plotNeurons( trainedNetwork )
%PLOTNEURONS Summary of this function goes here
%   Detailed explanation goes here
    i = real(trainedNetwork(:,1));
    j = imag(trainedNetwork(:,1));
    
    ij = [i j];

    length = size(ij,1);
    
    plotv([i(1); j(1)], '-');
    hold on;
    
    for n=2:length
        plotv([i(n); j(n)], '-');
    end
end

