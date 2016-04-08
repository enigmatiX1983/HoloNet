%sigmoidNorm.m - Sigmoid Normalization
%Fun
function [normStimVec] = sigmoidNorm(stimulus)

    stdDev = std(stimulus);
    stimMean = mean(stimulus);
    
    %Get the size of the stimulus vector
    temp = size(stimulus);
    stimVecSize = temp(2);
   
    %Create an empty array for the theta values
    nValues = zeros(1, stimVecSize);
    
    %%To catch the case 
    if stdDev == 0
        for n = 1:stimVecSize
            nValues(n) = ( 2 * pi ) / ( 1 + exp( -( stimulus(n) - stimMean )));
        end
    else
        for n = 1:stimVecSize
            nValues(n) = ( 2 * pi ) / ( 1 + exp( -( ( stimulus(n) - stimMean ) / stdDev )) );
        end        
    end
    

    
    %Normalize the nValues so that they fall within the unit circle
    %tempSum = sum(stimulus);
    %stimNorm = 1 / (expected range of values)
    %stimNorm = 1 / 5;
    
    %%Preallocat the vector
    normStimVec = zeros(1,stimVecSize);
    
    %Use Euler's formula to convert the angles into complex form
    for n = 1:stimVecSize
        %normStimVec(n) = stimNorm * stimulus(n) * ( cos(nValues(n)) + 1i * sin(nValues(n)) );
        normStimVec(n) = ( cos(nValues(n)) + i * sin(nValues(n)) );
    end
    
    %normStimVecr