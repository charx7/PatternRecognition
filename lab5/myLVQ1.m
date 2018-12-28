function [Epochcount,epochsError] = myLVQ1(dat,prototypes,class_labels,learningRate,plotMode,epochNumber)
%%
%Returns the Epochcount if the last parameter is not supplied. Also returns
%epochError based on euclidean distance metric. 

%If the last parameter 'epochNumber' is supplied by the user, the function
%stops when epoch number is reached by the for loop. Else, the function try
%to converge error rate. Variable 'epochNumber' prevents below function to
%escape for infinite loop and should be supplied when prototype count is
%too low compared to the class count

%Furthermore, the function has two plotting mode. Variable 'plotMode' set
%to 1 outputs scatter plot of prototypes overlaid on the data. when this
%variable set to 2, output is the plot of changing error rate for each
%epoch until convergence is achieved or the provided epoch number is
%reached.

%parameters of the algorithm
szData = size(dat);
numberOfExamples = szData(1);
epochsError = [];
errorRate = 1;
Epochcount = 0;
%%
if ~exist('epochNumber','var') || isempty(epochNumber)
    while (errorRate<0.99990) || (errorRate>0.99999)
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
    
            errorRate = 1;
        else
            lError = size(epochsError,1);
            errorRate = mean(epochsError(floor(lError*0.7):floor(lError*0.85)))/mean(epochsError(floor(lError*0.85):lError));
        end
        
        Epochcount = Epochcount + 1;

    end
else
    for k=1:epochNumber
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
    end
end

if plotMode == 1
    % Plot of the prototypes on top of the scatter
    for p=1:size(prototypes,1)
        plot(prototypes(p,1), prototypes(p,2), '*','MarkerSize',10);
        hold on
    end
    
    
else 
    % Plot the number of epochs vs error
    plot(epochsError);
    legend('Error')
    hold on
end
end

