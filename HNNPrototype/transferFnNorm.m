function [ transformedStimVec ] = transferFnNorm( stimulus, oneToOne )
%UNTITLED Returns normalized values
%   Detailed explanation goes here
    rng(1034);
    if oneToOne == 1
        noisyStimulus = stimulus + (rand(size(stimulus))/ 100);
        [f, x] = ecdf(noisyStimulus);
        %mapObj = containers.Map(x, (f*(1.97*pi))+0.047);
        mapObj = containers.Map(x, (f*(2*pi)));
    elseif oneToOne == 0   
        [f, x] = ecdf(stimulus);
        mapObj = containers.Map(x, (f*2*pi));
    end
    
    %Transform the stimulus
    sizeStim = size(stimulus);
    tempVec = zeros(sizeStim);
    transformedStimVec = zeros(sizeStim);
    for i=1:sizeStim(2)
        if oneToOne == 1
            tempVec(i) = mapObj(noisyStimulus(i));
        elseif oneToOne == 0
            tempVec(i) = mapObj(stimulus(i));
        end
        %Use Euler's formula to convert the angles into complex form
        transformedStimVec(i) = ( cos(tempVec(i)) + 1i * sin(tempVec(i)));
   
    end
end