function [ return_code ] = writeData( fileName, data )
%WRITEDATA Summary of this function goes here
%   Detailed explanation goes here
    csvwrite(fileName, data);    
end