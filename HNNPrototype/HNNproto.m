function trainedNetwork = HNNproto(stimVec, respVec, learningMode, epochs, symmetryFunc)
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
reportNumber = 100;

%%Preallocate the matrix array for the Stimulus Vector
%Preallocate two dimensional (one dimension x time) (sound)
if numel(stimVecSize) == 2
    stimMatrixNormal = zeros(stimVecSize(1), stimVecSize(2));
%Preallocate three dimensional (two dimension x time) (black and white vision)
elseif numel(stimVecSize) == 3
    stimMatrixNormal = zeros(stimVecSize(1), stimVecSize(2), stimVecSize(3));
end

%%Preallocate the matrix array for the Response Vector
%Preallocate two dimensional (one dimension x time) (sound)
if numel(respVecSize) == 2
    respMatrixNormal = zeros(respVecSize(1), respVecSize(2));
%Preallocate three dimensional (two dimension x time) (black and white vision)
elseif numel(respVecSize) == 3
    respMatrixNormal = zeros(respVecSize(1), respVecSize(2), respVecSize(3));
end

%%Process the stimulus vector
%Two dimensional case
if numel(stimVecSize) == 2
    for n=1:respVecSize(1)
        if symmetryFunc == 1
            stimMatrixNormal(n,:) =  sigmoidNorm(stimVec(n,:));
        elseif symmetryFunc == 2
            stimMatrixNormal(n,:) = transferFnNorm(stimVec(n,:));
        end
        
        if mod(n, reportNumber) == 0
            fprintf('Processing stimulus element %i\n', n);
        end
    end
%Three dimensional case
elseif numel(stimVecSize) == 3
    for n=1:stimVecSize(3)
        if symmetryFunc == 1
            stimMatrixNormal(:,:,n) =  sigmoidNorm(stimVec(:,:,n));
        elseif symmetryFunc == 2
            stimMatrixNormal(:,:,n) = transferFnNorm(stimVec(:,:,n), 1);
        end

        if mod(n, reportNumber) == 0
            fprintf('Processing stimulus element %i\n', n);
        end
    end
end

%%Process the response vector
%Two dimensional case
if numel(respVecSize) == 2
    for n=1:respVecSize(1)
        if symmetryFunc == 1
            respMatrixNormal(n,:) =  sigmoidNorm(respVec(n,:));
        elseif symmetryFunc == 2
            respMatrixNormal(n,:) =  transferFnNorm(respVec(n,:), 1);
        end
        
        if mod(n, reportNumber) == 0
            fprintf('Processing response element %i\n', n);
        end
    end
%Three dimensional case
elseif numel(respVecSize) == 3
    for n=1:respVecSize(3)
        if symmetryFunc == 1
            respMatrixNormal(:,:,n) =  sigmoidNorm(respVec(:,:,n));
        elseif symmetryFunc == 2
            respMatrixNormal(:,:,n) =  transferFnNorm(respVec(:,:,n), 1);
        end

        if mod(n, reportNumber) == 0
            fprintf('Processing response element %i\n', n);
        end
    end
end
 
if numel(stimVecSize) == 2
    trainedNetwork = zeros( stimVecSize(2), respVecSize(2));
elseif numel(stimVecSize) == 3
    trainedNetwork = zeros (stimVecSize(1), stimVecSize(2), respVecSize(2));
end

%temp 
respMatrixNormal = respMatrixNormal';
              
%learningMode 1; Original learning no Hermetian
if learningMode == 1  
    for m=1:epochs
        if numel(stimVecSize) == 2
            %Train the network
            for n=1:stimVecSize
                trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(n,:))* respMatrixNormal(n,:));
            end
        elseif numel(stimVecSize) == 3
            %Train the network
            for n=1:stimVecSize
                trainedNetwork = trainedNetwork + (ctranspose(stimMatrixNormal(:,:,n))* respMatrixNormal(n,:));
            end
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