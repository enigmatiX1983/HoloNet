%sigmoidNorm.m - Sigmoid Normalization
function [normStimVec, vecMap] = sigmoidNormTest(stimulus)

    %stdDev = std(255);
    %stimMean = mean();
    
    %Get the size of the stimulus vector
    temp = size(stimulus);
    stimVecSize = temp(2);
       
    %Create an empty array for the theta values
    stimMean = mean(stimulus);
    stimStdDev = std(stimulus);
    nValues = zeros(1, stimVecSize); 
    
    for n = 1:stimVecSize
            nValues(n) = ( 2 * pi ) / ( 1 + exp( -( (stimulus(n) - stimMean)/stimStdDev )));
    end
    
    %%Preallocat the vector
    normStimVec = zeros(1,stimVecSize);
    
    vecMap = containers.Map(stimulus, normStimVec);
    
    %Use Euler's formula to convert the angles into complex form
    for n = 1:stimVecSize
        %normStimVec(n) = stimNorm * stimulus(n) * ( cos(nValues(n)) + 1i * sin(nValues(n)) );
        normStimVec(n) = ( cos(nValues(n)) + 1i * sin(nValues(n)) );
    end