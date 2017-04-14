function [ processedRespVec ] = processStimuli( stimVec )
%PROCESSRESPONSES Summary of this function goes here
%   Detailed explanation goes here
    uniqueValues = 0:255;
    
    %Get the size of the unique values
    sizeUniqueValues = size(uniqueValues);
       
    %Create an empty array for the theta values
    nValues = zeros(1,sizeUniqueValues(2)); 
    
    %Calculate size of the vector
    c = size(nValues, 2);
    
    for n = 1:c
            nValues(n) = ((360/c)*uniqueValues(n))*(pi/180);
            %nValues(n) = ( 2 * pi ) / ( 1 + exp( -( stimulus(n) - stimMean )));
    end
    
    mapObj = containers.Map(uniqueValues, nValues);
    
    %%Preallocate the vector
    respVecSize = size(stimVec);
    processedRespVec = zeros(1, respVecSize(2));
    
    %Use Euler's formula to convert the angles into complex form
    for n = 1:respVecSize(2)
        %normStimVec(n) = stimNorm * stimulus(n) * ( cos(nValues(n)) + 1i * sin(nValues(n)) );
        processedRespVec(n) = ( cos(mapObj(stimVec(n))) + 1i * sin(mapObj(stimVec(n))) );
    end 

end

