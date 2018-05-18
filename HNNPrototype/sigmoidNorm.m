%%sigmoidNorm.m - Sigmoid Normalization
%%This function takes a set of stimuli, and evenly distributes them around
%%the cicular complex domain using a sigmoid function.  Works very well for
%%input that follows a normal distribution
function [normStimVec, vecMap] = sigmoidNorm(stimulus)
    %Get the size of the stimulus vector
    temp = size(stimulus);
    stimVecSize = temp(2);
       
    %Create an empty array for the theta values
    nValues = zeros(1, stimVecSize); 
    
    %Calculate size of the vector
    c = size(stimulus, 2);
    
    for n = 1:stimVecSize
            nValues(n) = ((360/c)*stimulus(n))*(pi/180);
            %nValues(n) = ( 2 * pi ) / ( 1 + exp( -( stimulus(n) - stimMean )));
    end
    
    %%Preallocate the vectorv
    normStimVec = zeros(1,stimVecSize);
    
    vecMap = containers.Map(stimulus, nValues)
    
    %Use Euler's formula to convert the angles into complex form
    for n = 1:stimVecSize
        %normStimVec(n) = stimNorm * stimulus(n) * ( cos(nValues(n)) + 1i * sin(nValues(n)) );
        normStimVec(n) = ( cos(nValues(n)) + 1i * sin(nValues(n)) );
    end 