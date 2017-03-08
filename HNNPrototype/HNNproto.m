function trainedNetwork = HNNproto(stimVec, respVec, learningMode, iterations)
%%EXAMPLE
%

%learningMode 1: Original
%learningMode 2 : Improved

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
    
trainedNetwork = zeros( stimVecSize(2), respVecSize(2));
%trainedNetwork = complex(trainedNetwork) + 1i
%trainedNetwork = sigmoidNorm([1 2 3 4 5])'          


%c = stimVecSize(2);

for m=1:iterations
    %learningMode
    %1 == Original learning no Hermetian
    %2 == Improved learning no Hermetian
    %3 == Original learning Hermetian
    %4 == Improved learning Hermetian
    
    %learningMode 1; Original learning no Hermetian
    if learningMode == 1  
        %Train the network
        for n=1:stimVecSize
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:));
        end   
    %learningMode 2; Original learning Hermetian
    elseif learningMode == 2
        if m == 1
            %Train the network to populate the correlation matrix
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
        end
        %train the rest
        for n=2:stimVecSize
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));
            
            RPrime = (1/c)*(stimMatrixNormal(n,:) * trainedNetwork);

            RDiff = respMatrixNormal(n,:) - RPrime;
            %RDiff = dot(respMatrixNormal(n,:), RPrime)
            
            % X += ctranspose(S)*RDiff
            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))*RDiff));
        end    
    %learningMode 3; Original learning Hermetian
    elseif learningMode == 3
        if m == 1
            %Train the network to populate the correlation matrix
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
        end

        %train the rest
        for n=2:stimVecSize            
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));

            %Create Hermetian for higher order statistics
            H = (1/c)*ctranspose(stimMatrixNormal(n,:))*stimMatrixNormal(n,:);
            
            RPrime = H * trainedNetwork;          

            % X += ctranspose(S)*RDiff
            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:)) - RPrime); 
        end
    %learningMode 4; Improved learning Hermetian
    elseif learningMode == 4
        if m == 1
            trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(1,:))* respMatrixNormal(1,:));
        end

        %train the rest
        for n=2:stimVecSize
            %Compute the normalization co-efficient
            c = sum(abs(stimMatrixNormal(n,:)));

            %Create Hermetian for higher order statistics
            H = (1/c)*ctranspose(stimMatrixNormal(n,:))*stimMatrixNormal(n,:);
            
            RPrime = H * trainedNetwork;         

            % X += ctranspose(S)*RDiff
            trainedNetwork = trainedNetwork + ((ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:)) - RPrime);
        end        
        
    end
end