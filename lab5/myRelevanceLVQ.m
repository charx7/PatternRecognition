function [Epochcount,epochsError,prototypeList,predictedLabels,lamdas] = myRelevanceLVQ(dat,prototypes,class_labels,learningRate,plotMode)

    % Same init parameters ans the normal LVQ
    %init parameters
    szData = size(dat);
    numberOfExamples = szData(1);
    epochsError = [];
    errorRatio = 2;
    Epochcount = 0;
    predictedLabels = [];
    prototypeList = [];
    lamdaLearning = 0.005;
    lamda1 = 0.5;
    lamda2 = 0.5;

    if exist('class_labels','Var')
        while (errorRatio<0.99990) || (errorRatio>=1)
            currentEpochError = 0;
                % Do the loop for the number of numberOfExamples
                for i = 1:numberOfExamples
                    % Get the current Point
                    currentPoint = dat(i,:);
                    % Calculate the distances
                    %currentDistance = pdist2(currentPoint, prototypes(:,1:2),'euclidean');
                    currentDistance = lambdaEuclidean(currentPoint, prototypes(:,1:2), lamda1, lamda2);

                    % Square the dist measure
                    currentDistanceSquare = currentDistance.^2;
                    % Calculate the min
                    [currentMin, minIdx] = min(currentDistanceSquare);

                    % Update the positions of the prototypes based on the winner 
                    % Get the winner closer
                    winnerLabel = prototypes(minIdx,3);
                    currentLabel = class_labels(i);
                    if winnerLabel == currentLabel
                        % Move closer the winning prototype
                        prototypes(minIdx,1:2) = prototypes(minIdx,1:2) + learningRate * (currentPoint - prototypes(minIdx,1:2));
                    else
                        currentEpochError = currentEpochError + 1;
                        % Push away the winning prototype
                        prototypes(minIdx,1:2) = prototypes(minIdx,1:2) - learningRate * (currentPoint - prototypes(minIdx,1:2));
                    end
                    
                    % Update the relevances based on the global criterion
                    if winnerLabel == currentLabel
                        % Contribute of the j dimension decrease
                        lamda1 = lamda1 - lamdaLearning * abs(currentPoint(1) - prototypes(minIdx,1));
                        % Restrictions >0 and lamdas sum = 1
                        if lamda1 < 0
                            lamda1 = 0;
                        end
                        lamda2 = 1 - lamda1;
                    else
                        % Contribute of the j dimension increase
                        lamda1 = lamda1 + lamdaLearning * abs(currentPoint(1) - prototypes(minIdx,1));
                        % Restrictions >0 and lamdas sum = 1
                        if lamda1 < 0
                            lamda1 = 0;
                        end
                        lamda2 = 1 - lamda1;
                    end
                    %prototypes([1:minIdx-1 minIdx+1:end],:) = prototypes([1:minIdx-1 minIdx+1:end],:) - learningRate*repmat(currentPoint,2,1);
                end
            % Add to the epochs error matrix
            currentErrorRate = currentEpochError / numberOfExamples;
            epochsError = [epochsError; currentErrorRate];

            %calculate whether t approaches constant
            if size(epochsError,1) < 2
                errorRatio = 2;
            else
                lError = size(epochsError,1);
                errorRatio = mean(epochsError(floor(lError*0.7):floor(lError*0.85)))/mean(epochsError(floor(lError*0.85):lError));
            end
            
            Epochcount = Epochcount + 1;
            prototypeList = prototypes;

        end
        disp('I finished looping weee');
    end
    if ~exist('class_labels','Var') || isempty(class_labels)
        %initiate list of zeros for predictedLabels
        predicted = zeros(numberOfExamples,1);

        %predict new labels
        for f =1:numberOfExamples
            currentPoint = dat(f,:);
            % Calculate the distances
            %currentDistance = pdist2(currentPoint, prototypes(:,1:2),'euclidean');
            currentDistance = lambdaEuclidean(currentPoint, prototypes(:,1:2), lamda1, lamda2);

            % Square the dist measure
            currentDistanceSquare = currentDistance.^2;
            % Calculate the min
            [currentMin, minIdx] = min(currentDistanceSquare);
            %store predicted labels
            predicted(f,1) = prototypes(minIdx,3);
        end

        predictedLabels = predicted;
    end

    if exist('plotMode','Var')
        if plotMode == 1
            % Plot of the prototypes on top of the scatter
            for p=1:size(prototypes,1)
                plot(prototypes(p,1), prototypes(p,2), '*','MarkerSize',10);
                hold on
            end

        elseif plotMode == 2
            % Plot the number of epochs vs error
            plot(epochsError);
            legend('Error')
            hold on

        end
    end
end

function distances = lambdaEuclidean(currentPoint, prototypes, lamda1, lamda2)
    % Construct array of zeros which will store the distances
    protoLen = length(prototypes);
    %dist = zeros(protoLen,1);
    % Loop over the prototypes
    dist = ((lamda1 * currentPoint(1) - prototypes(:,1)).^2) + ((lamda2 * currentPoint(1)- prototypes(:,2)).^2);
    % Function return the transpose to determine the winner
    distances = transpose(dist);
end