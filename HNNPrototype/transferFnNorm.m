function [ output_args ] = transferFnNorm( stimulus )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [f, x] = ecdf(stimulus);
    transferFunction = f * 2 * pi;
    
    
    
end