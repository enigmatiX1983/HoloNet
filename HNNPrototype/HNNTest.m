%%Example: 
function [output] = HNNTest( stimFile, respFile, learningMode, epochs )

    stimVec = importdata(stimFile);
    respVec = importdata(respFile);

    %stimVec = importdata('testdata/stimuluslist.dat');
    %respVec = importdata('testdata/responselist.dat');
    
    output = HNNproto(stimVec, respVec, learningMode, epochs);