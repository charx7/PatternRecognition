function [Epochcount,epochsError,prototypeList,predictedLabels] = myLVQ1(dat,prototypes,class_labels,learningRate,plotMode)
%%
%Returns: 
%Epochcount - epoch count if the last parameter is not supplied.
%epochError - calculated error of an epoch based on euclidean distance metric. 
%prototypeList - updated prototype coordinate points
%predictedLabels - new class labels for each data point

%If the parameter 'class_labels' is supplied by the user, the function
%trains on the data supplied by 'dat' variable. Otherwise, the function
%makes prediction.

%Furthermore, the function has two plotting mode. Variable 'plotMode' set
%to 1 outputs scatter plot of prototypes overlaid on the data. when this
%variable set to 2, output is the plot of changing error rate for each
%epoch until convergence is achieved or the provided epoch number is
%reached.

%init parameters
szData = size(dat);
numberOfExamples = szData(1);
epochsError = [];
errorRatio = 2;
Epochcount = 0;
predictedLabels = [];
prototypeList = [];
%%
if exist('class_labels','Var')
    while (errorRatio<0.99990) || (errorRatio>=1)
        currentEpochError = 0;
            % Do the loop for the number of numberOfExamples
            for i = 1:numberOfExamples
            % Get the current Point
            currentPoint = dat(i,:);
            % Calculate the distances
            currentDistance = pdist2(currentPoint, prototypes(:,1:2),'euclidean');
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
end
if ~exist('class_labels','Var') || isempty(class_labels)
    %initiate list of zeros for predictedLabels
    predicted = zeros(numberOfExamples,1);

    %predict new labels
    for f =1:numberOfExamples
        currentPoint = dat(f,:);
        % Calculate the distances
        currentDistance = pdist2(currentPoint, prototypes(:,1:2),'euclidean');
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
