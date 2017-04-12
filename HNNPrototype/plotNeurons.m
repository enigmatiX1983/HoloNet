function [ output_args ] = plotNeurons( network )
%PLOTNEURONS Summary of this function goes here
%   Detailed explanation goes here

    matrixSize = size(network)
    for m = 1:matrixSize(1)
        for n = 1:matrixSize(2)
            i = real(network(m,n));
            j = imag(network(m,n));
            
            plotv([i; j], '-');
            hold on;
        end
    end
end

