function trainedNetwork = HNNproto(stimVec, respVec, learningMode, epochs)
%learningMode
%1 == Original learning no Hermetian
%2 == Improved learning no Hermetian
%3 == Original learning Hermetian
%4 == Improved learning Hermetian

stimVecSize = size(stimVec);
respVecSize = size(respVec);

%%Preallocate the matrix array
stimMatrixNormal = zeros(stimVecSize(1), stimVecSize(2));
respMatrixNormal = zeros(respVecSize(1), respVecSize(2));

%%Process the stimulus vector
for n=1:stimVecSize(1)
    stimMatrixNormal(n,:) =  sigmoidNorm(stimVec(n,:));
end

%%Process the response vector
for n=1:respVecSize(1)
    respMatrixNormal(n,:) =  sigmoidNorm(respVec(n,:));
end
    
trainedNetwork = zeros( stimVecSize(2), respVecSize(2));
              
%learningMode 1; Original learning no Hermetian
if learningMode == 1  
    for m=1:epochs      
        %Train the network
        for n=1:stimVecSize
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:));
        end
    end
%learningMode 2; improved learning no Hermetian
elseif learningMode == 2
    for m=1:epochs 
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
elseif learningMode == 3
    for m=1:epochs 
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
elseif learningMode == 4
    for m=1:epochs 
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