%%Example: 
function [trainedNetwork] = HNNTest( stimFile, respFile, learningMode, epochs )

    stimVec = importdata(stimFile);
    respVec = importdata(respFile);

    %stimVec = importdata('testdata/stimuluslist.dat');
    %respVec = importdata('testdata/responselist.dat');
    
    trainedNetwork = HNNproto(stimVec, respVec, learningMode, epochs);
    
    tmpDifferenceVec = zeros(size(respVec));
    
    stimVecCount = size(stimVec, 1);
    
    %Temporary c value
    c = size(stimVec, 2);
    
    %Generate actual results to compare to
    for n=1:stimVecCount
        tmpDifferenceVec(n) = ((1/c)*sigmoidNorm(stimVec(n,:))*trainedNetwork) - sigmoidNorm(respVec(n));
    end
    
    plotNeurons(trainedNetwork);
    
    tmpDifferenceVec