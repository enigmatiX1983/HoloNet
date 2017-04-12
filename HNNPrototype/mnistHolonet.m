function [ ] = mnistHolonet( learningMode, epochs, symmetryFunc )
%MNISTHOLONET Summary of this function goes here
%   Detailed explanation goes here
    mnistImages = loadMNISTImages('training_images\train-images.idx3-ubyte');
    mnistLables = loadMNISTLabels('training_labels\train-labels.idx1-ubyte');
    
    trainedNetwork = HNNproto(mnistImages, mnistLables, learningMode, epochs, symmetryFunc);
    
    tmpDifferenceVec = zeros(size(mnistLables));
    
    stimVecCount = size(mnistImages, 1);
    
    %Temporary c value
    c = size(mnistImages, 2);
    
    %Generate actual results to compare to
    for n=1:stimVecCount
        tmpDifferenceVec(n) = ((1/c)*sigmoidNorm(mnistImages(n,:))*trainedNetwork) - sigmoidNorm(mnistLables(n));
    end
     
    plotNeurons(trainedNetwork);
    
end

