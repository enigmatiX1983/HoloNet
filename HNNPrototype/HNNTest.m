function [output] = HNNTest( trainedNetwork, stimVec, respVec )


    stimVecSize = size(stimVec);
    respVecSize = size(respVec);

    %%Preallocate the matrix array
    stimMatrixNormal = zeros(stimVecSize(1), stimVecSize(2));
    respMatrixNormal = zeros(respVecSize(1), respVecSize(2));
    %hiddMatrixNormal = zeros(1, stimVecSize(2));

    %%Process the stimulus vector
    for n=1:stimVecSize(1)
        stimMatrixNormal(n,:) =  sigmoidNorm(stimVec(n,:));
    end
    
    %%Process the response vector
    for n=1:respVecSize(1)
        respMatrixNormal(n,:) =  sigmoidNorm(respVec(n,:));
    end
    
    %Compute the normalization co-efficient
    c = sum(abs(stimMatrixNormal(n,:)));
    
    %%%RUN THE TESTS
    stimResult = (1/c)*