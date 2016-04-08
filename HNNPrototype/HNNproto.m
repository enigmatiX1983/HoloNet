function trainedNetwork = HNNProto(stimVec, respVec)
%This function does something

stimVecSize = size(stimVec)
respVecSize = size(respVec)

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

%%Process the dot products to find the phase-angle difference between the complex
%%vectors
%for m=1:stimVecSize(1)  
%    stimMatrixNormal
%    respMatrixNormal
%    for n=1:stimVecSize(2)
%        m
%        n
%        hiddMatrixNormal(1,n) = hiddMatrixNormal(1,n) + dot(ctranspose(stimMatrixNormal(m,n)'), respMatrixNormal(m,n))
%end
%    
%end

%create the random X matrix
%X = exp(1i *   pi * rand(stimVecSize(2), stimVecSize(2)))
X = zeros(stimVecSize(2), stimVecSize(2));

stimMatrixNormal
respMatrixNormal

X

%%Train the network
for n=1:stimVecSize
    stimMatrixNormal(n,:)
    respMatrixNormal(n,:)
    X = X + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:))
end

X

testMat = [ 1 2 3 4 5 ];
num = sum(testMat)

R = (1/5)*sigmoidNorm(testMat)*X
%testMatNorm = sigmoidNorm(testMat)
%oneOverC = 1/sum(testMat);
%resultMatrix = zeros(1,5);

%for m=1:5
%    resultMatrix(1,m) = dot(testMatNorm(1,m), hiddMatrixNormal(1,m)');
    %resultMatrix(1,m) = dot(hiddMatrixNormal(1,m), testMatNorm(1,m));
%end

%resultMatrix



%train the network with the new input

