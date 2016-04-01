%sigmoidNorm.m - Sigmoid Normalization
%Fun
function [normStimVec] = sigmoidNorm(stimulus)

    stdDev = std(stimulus);
    stimMean = mean(stimulus);
    
    %Get the size of the stimulus vector
    temp = size(stimulus);
    stimVecSize = temp(2);
   
    %Create an empty array for the theta values
    nValues = ones(1, stimVecSize);
      
    for n = 1:stimVecSize
        nValues(n) = ( 2 * pi ) / ( 1 + exp( -( ( stimulus(n) - stimMean ) / stdDev )) )
    end
    
    %Normalize the nValues so that they fall within the unit circle
    tempSum = sum(stimulus);
    stimNorm = stimulus / tempSum;
        
    %Use Euler's formula to convert the angles into complex form
    for n = 1:stimVecSize
        normStimVec(n) = stimNorm(n) * ( cos(nValues(n)) + i * sin(nValues(n)) );
    end