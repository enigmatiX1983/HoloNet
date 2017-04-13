function [ ] = mnistHolonet( learningMode, symmetryFunc, oneToOneStimProc, numImagesToTrain, epochs )
%MNISTHOLONET Summary of this function goes here
%   Detailed explanation goes here
    mnistImages = loadMNISTImages('training_images\train-images.idx3-ubyte');
    mnistLables = loadMNISTLabels('training_labels\train-labels.idx1-ubyte');
    
    stimVec = mnistImages(:,1:numImagesToTrain)' * 255;
    respVec = mnistLables(1:numImagesToTrain,:);

    trainedNetwork = HNNproto(stimVec, respVec, learningMode, symmetryFunc, oneToOneStimProc, epochs );
    
    tmpDifferenceVec = zeros(size(respVec));
    
    stimVecCount = size(stimVec, 1);
    
    %Temporary c value
    c = size(stimVec, 2);
    
    %Generate actual results to compare to
    if strcmp('sigmoid', symmetryFunc)
        idealResponseVec = sigmoidNorm(respVec')';
        for n=1:stimVecCount
            tmpDifferenceVec(n) = ((1/c)*sigmoidNorm(stimVec(n,:))*trainedNetwork) - idealResponseVec(n)
        end
    elseif strcmp('improvedTransfer', symmetryFunc)
        idealResponseVec = transferFnNorm(respVec', oneToOneStimProc)';
        for n=1:stimVecCount
            tmpDifferenceVec(n) = ((1/c)*transferFnNorm(stimVec(n,:), oneToOneStimProc)*trainedNetwork) - idealResponseVec(n)
        end        
    end
        
     
    plotNeurons(trainedNetwork);
    
end

