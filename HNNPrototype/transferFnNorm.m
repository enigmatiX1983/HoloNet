%%Function provides a better way of transforming input vectors than
%%sigmoidNorm (which uses a normal distribution).  Better where inputs do
%%not follow a normal distribution.
function [ transformedStimVec, stimMapObj, mapObj ] = transferFnNorm( stimulus, oneToOne )
%UNTITLED Returns normalized values
    
    rng(1034);
    
    %%Here, for the holographic neural network, if oneToOne is selected, we
    %%add noise so that we do not have too many zero values (will all be
    %%mapped to the same complex value
    if oneToOne == 1
        noisyStimulus = stimulus + (rand(size(stimulus))/ 100);
        [f, x] = ecdf(noisyStimulus);
        %mapObj = containers.Map(x, (f*(1.97*pi))+0.047);
        mapObj = containers.Map(x, (f*(2*pi)));
    elseif oneToOne == 0   
        [f, x] = ecdf(stimulus);
        mapObj = containers.Map(x, (f*2*pi));
    end
    
    noisyStim = x';
    stimMapObj = containers.Map(stimulus, noisyStim(2:end));
    
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