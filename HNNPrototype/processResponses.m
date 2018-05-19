function [ processedRespVec ] = processResponses( symmetryFunc, respVec, vecMap )  
    respVecSize = size(respVec);
    processedRespVec = zeros(1, respVecSize(2));
    %%Preallocate the vector
    if strcmp('sigmoid', symmetryFunc)
        processedRespVec = ( cos(vecMap(respVec)) + 1i * sin(vecMap(respVec)) );
    end
    
    if strcmp('sigmoid', symmetryFunc)
        processedRespVec = ( cos(vecMap(respVec)) + 1i * sin(vecMap(respVec)) );
    end
end

