function trainedNetwork = HNNproto(stimVec, respVec, learningMode, symmetryFunc, oneToOneStimProc, epochs )
%learningMode
%1 == Original learning no Hermetian
%2 == Improved learning no Hermetian
%3 == Original learning Hermetian
%4 == Improved learning Hermetian

%symmetryFunc
%1 == sigmoidNorm
%2 == transferFunc

stimVecSize = size(stimVec);
respVecSize = size(respVec);

%%Preallocate the matrix array
stimMatrixNormal = zeros(stimVecSize(1), stimVecSize(2));
respMatrixNormal = zeros(respVecSize(1), respVecSize(2));

%%Process the stimulus vector
for n=1:stimVecSize(1)
    if strcmp('sigmoid', symmetryFunc)
        stimMatrixNormal(n,:) =  sigmoidNorm(stimVec(n,:));
    elseif strcmp('improvedTransfer', symmetryFunc)
        stimMatrixNormal(n,:) = transferFnNorm(stimVec(n,:), oneToOneStimProc);
    end
    
    %stimMatrixNormal(n,:) = processStimuli(stimVec(n,:));
    
    if mod(n, 10) == 0
        fprintf('Processing stimulus element %i\n', n);
    end
end

%%Process the response vector
for n=1:respVecSize(2)
    respMatrixNormal = processResponses(respVec(:,n)')';
end
    
trainedNetwork = zeros( stimVecSize(2), respVecSize(2));
              
%learningMode 1; Original learning no Hermetian
if strcmp('original', learningMode)  
    for m=1:epochs
        fprintf('Original learning algorithm with no Hermetian, epoch %i\n', m);
        %Train the network
        for n=1:stimVecSize
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:));
        end
    end
%learningMode 2; improved learning no Hermetian
elseif strcmp('improved', learningMode) 
    for m=1:epochs 
        fprintf('Improved learning algorithm with no Hermetian, epoch %i\n', m);
        n = 1;

        if m == 1
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
            n = 2;
        end

        %train the rest
        while n <= stimVecSize            
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));

            RPrime = (1/c)*(stimMatrixNormal(n,:) * trainedNetwork);

            RDiff = respMatrixNormal(n,:) - RPrime;            

            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))*RDiff));
            n = n + 1; 
        end
    end
%learningMode 3; Original learning Hermetian
elseif strcmp('originalWithHermetian', learningMode) 
    for m=1:epochs 
        fprintf('Original learning algorithm with Hermetian, epoch %i\n', m);
        n = 1;

        if m == 1
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
            n = 2;
        end

        %train the rest
        while n <= stimVecSize
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));

            %Create Hermetian for higher order statistics
            H = (1/c)*ctranspose(stimMatrixNormal(n,:))*stimMatrixNormal(n,:);

            RPrime = H * trainedNetwork;

            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:)) - RPrime);
            n = n + 1; 
        end
    end
%learningMode 4; Improved learning Hermetian
elseif strcmp('improvedWithHermetian', learningMode) 
    for m=1:epochs 
        fprintf('Improved learning algorithm with Hermetian, epoch %i\n', m);
        n = 1;

        if m == 1
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
            n = 2;
        end

        %train the rest
        while n <= stimVecSize            
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));

            %Create Hermetian for higher order statistics
            H = (1/c)*ctranspose(stimMatrixNormal(n,:))*stimMatrixNormal(n,:);

            RPrime = H * trainedNetwork;

            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:)) - RPrime);
            n = n + 1; 
        end
    end
end