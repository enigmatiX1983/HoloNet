function [ data ] = readData( fileName, dimensions )
%READDATA Summary of this function goes here
%   Detailed explanation goes here
    data = csvread(fileName);
    data = reshape( data, dimensions );
end

