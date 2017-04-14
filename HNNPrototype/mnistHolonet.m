function [ ] = mnistHolonet( learningMode, symmetryFunc, oneToOneStimProc, numImagesToTrain, epochs )
%MNISTHOLONET Summary of this function goes here
%   Detailed explanation goes here
    mnistTrainingImages = loadMNISTImages('training_images\train-images.idx3-ubyte');
    mnistTrainingLables = loadMNISTLabels('training_labels\train-labels.idx1-ubyte');
    mnistTestImages = loadMNISTImages('test_images\t10k-images.idx3-ubyte');
    mnistTestLables = loadMNISTLabels('test_labels\t10k-labels.idx1-ubyte');
    
    %Multiply by 255 to un-normalize (RGB)
    stimVec = mnistTrainingImages(:,1:numImagesToTrain)' * 255;
    respVec = mnistTrainingLables(1:numImagesToTrain,:);

    trainedNetwork = HNNproto(stimVec, respVec, learningMode, symmetryFunc, oneToOneStimProc, epochs );
    
    tmpDifferenceVec = zeros(size(respVec));
    
    stimVecCount = size(stimVec, 1);
    
    %Temporary c value
    c = size(stimVec, 2);
    
    %Generate actual results to compare to
    %Functions as a sanity check, the closer the tmpDifferenceVec values
    %are to zero, the better trained the network would be
    idealResponseVec = processResponses(respVec')';
    if strcmp('sigmoid', symmetryFunc)    
        for n=1:stimVecCount
            tmpDifferenceVec(n) = ((1/c)*sigmoidNorm(stimVec(n,:))*trainedNetwork) - idealResponseVec(n);
        end
    elseif strcmp('improvedTransfer', symmetryFunc)
        for n=1:stimVecCount
            tmpDifferenceVec(n) = ((1/c)*transferFnNorm(stimVec(n,:), oneToOneStimProc)*trainedNetwork) - idealResponseVec(n);
        end        
    end
    
    %plotNeurons(trainedNetwork);
    
    %Generate the test results using the test images
    %Multiply by 255 to un-normalize (RGB)
    testStimVec = mnistTestImages(:,:)' * 255;
    testRespVec = mnistTestLables(:,:);
    
    %Convert the test response vectors to polar
    testRespVecPolar = processResponses(respVec')';
    
    c = size(testStimVec, 2);
    testStimVecCount = size(testStimVec, 1);
    generatedResponses = zeros(size(testRespVec));
    
    if strcmp('sigmoid', symmetryFunc)
        for n=1:testStimVecCount
            generatedResponses(n) = ((1/c)*sigmoidNorm(testStimVec(n,:))*trainedNetwork);
        end
    elseif strcmp('improvedTransfer', symmetryFunc)
        for n=1:testStimVecCount
            generatedResponses(n) = ((1/c)*transferFnNorm(testStimVec(n,:), oneToOneStimProc)*trainedNetwork);
        end        
    end    
        
     

    
end

