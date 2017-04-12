function [ transformedStimVec ] = transferFnNorm( stimulus, oneToOne )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    noisyStimulus = stimulus + (rand(size(stimulus))/ 1000);
    reshapedNoisyStimulus = reshape(noisyStimulus, [1 numel(noisyStimulus)]);
    [f, x] = ecdf(reshapedNoisyStimulus);
    if oneToOne == 1
        mapObj = containers.Map(x, (f*2*pi));
    elseif oneToOne == 0
        mapObj = containers.Map(round(x), (f*2*pi));
    end
    
    %Transform the stimulus
    sizeStim = size(stimulus);
    tempVec = zeros(sizeStim);
    transformedStimVec = zeros(sizeStim);
    for i=1:sizeStim(1)
        for j=1:sizeStim(2)
            tempVec(i,j) = mapObj(round(noisyStimulus(i,j)));
            %Use Euler's formula to convert the angles into complex form
            transformedStimVec(i,j) = ( cos(tempVec(i,j)) + 1i * sin(tempVec(i,j)));
        end
    end
end