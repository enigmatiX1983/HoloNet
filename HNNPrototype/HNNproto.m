function trainedNetwork = HNNproto(stimVec, respVec)
%This function does something

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

trainedNetwork = zeros(stimVecSize(2), respVecSize(2));

%Train the network
for n=1:stimVecSize
    stimMatrixNormal(n,:)
    respMatrixNormal(n,:)
    trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:));
end
