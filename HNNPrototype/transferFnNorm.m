function [ transformedStimVec ] = transferFnNorm( stimulus, oneToOne )
%UNTITLED Returns normalized values
%   Detailed explanation goes here
    if oneToOne == 1
        noisyStimulus = stimulus + (rand(size(stimulus))/ 1000);
        reshapedNoisyStimulus = reshape(noisyStimulus, [1 numel(noisyStimulus)]);
        [f, x] = ecdf(reshapedNoisyStimulus);
        mapObj = containers.Map(x, (f*2*pi));
    elseif oneToOne == 0   
        reshapedStimulus = reshape(stimulus, [1 numel(stimulus)]);
        [f, x] = ecdf(reshapedStimulus);
        mapObj = containers.Map(round(x), (f*2*pi));
    end
    
    %Transform the stimulus
    sizeStim = size(stimulus);
    tempVec = zeros(sizeStim);
    transformedStimVec = zeros(sizeStim);
    for i=1:sizeStim(1)
        for j=1:sizeStim(2)
            if oneToOne == 1
                tempVec(i,j) = mapObj(noisyStimulus(i,j));
            elseif oneToOne == 0
                tempVec(i,j) = mapObj(stimulus(i,j));
            end
            %Use Euler's formula to convert the angles into complex form
            transformedStimVec(i,j) = ( cos(tempVec(i,j)) + 1i * sin(tempVec(i,j)));
        end
    end
end