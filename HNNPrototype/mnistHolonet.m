function [ ] = mnistHolonet( learningMode, epochs, symmetryFunc, numImagesToTrain )
%MNISTHOLONET Summary of this function goes here
%   Detailed explanation goes here
    mnistImages = loadMNISTImages('training_images\train-images.idx3-ubyte');
    mnistLables = loadMNISTLabels('training_labels\train-labels.idx1-ubyte');
    
    %[28 28 60000]
    stimVec = reshape(mnistImages*255, [28 28 60000]);
    respVec = reshape(mnistLables, [1 60000]);
    
    stimVec = stimVec(:,:,1:numImagesToTrain);
    respVec = respVec(:,1:numImagesToTrain);

    trainedNetwork = HNNproto(stimVec, respVec, learningMode, epochs, symmetryFunc);
    
    tmpDifferenceVec = zeros(size(respVec));
    
    stimVecCount = size(stimVec, 1);
    
    %Temporary c value
    c = size(stimVec, 2);
    
    %Generate actual results to compare to
    for n=1:stimVecCount
        tmpDifferenceVec(n) = ((1/c)*sigmoidNorm(stimVec(n,:))*trainedNetwork) - sigmoidNorm(respVec(n));
    end
     
    plotNeurons(trainedNetwork);
    
end

