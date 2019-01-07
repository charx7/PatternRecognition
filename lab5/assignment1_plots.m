clc;
clear;

% Load dataz
load1 = load('data_lvq_A.mat');
load2 = load('data_lvq_B.mat');

data1mat = cell2mat(struct2cell(load1));
% Add labels
class1 = zeros(200,1);

data2mat = cell2mat(struct2cell(load2));
% Add labels
class2 = ones(200,1);

% Scatter plot
figure
scatter(data1mat(:,1), data1mat(:,2));

% Join data
fullData = [data1mat; data2mat];

hold on
scatter(data2mat(:,1), data2mat(:,2));
hold on
legend('Class 1','Class 2')
title('Scatter Plot of 2 classes');

% Main LVQ-1
numberOfPrototypes = 3;
numberOfClasses = 2;

% Class labels
class_labels = floor( (0:length(fullData)-1) * numberOfClasses / length(fullData) );

% Calculate the class conditional means
class1mean = mean(data1mat);
class2mean = mean(data2mat);

% Init prototypes
%prototypes = zeros(3,2);

% Add random noise for each prototype
% Init weights with random noise
prototype1 = class1mean + randn(size(class1mean));
prototype2 = class1mean + randn(size(class1mean));
prototype3 = class1mean + randn(size(class1mean));

% Vectorize
prototypes = [prototype1 0; prototype2 1; prototype3 0];
%prototypes = [prototype1 0; prototype2 1];

% parameters of the algo
szData = size(fullData);
numberOfExamples = szData(1);
learningRate = 0.01; 
epochs = 25;
epochsError = [];

% Main epochs loop
for j = 1:epochs
    currentEpochError = 0;
    % Do the loop for the number of epochs
    for i = 1:numberOfExamples
        % Get the current Point
        currentPoint = fullData(i,:);
        % Calculate the distances
        currentDistance = pdist2(currentPoint, prototypes(:,1:2),'euclidean');
        % Square the dist measure
        currentDistanceSquare = currentDistance.^2;
        % Calculate the min
        [currentMin minIdx] = min(currentDistanceSquare);

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

% Plot of the prototypes on top of the scatter
plot(prototypes(1,1), prototypes(1,2), 'r*','color','b','MarkerSize',10);
plot(prototypes(2,1), prototypes(2,2), 'r*','color','g','MarkerSize',10);
plot(prototypes(3,1), prototypes(3,2), 'r*','color','r','MarkerSize',10);
hold on

% Plot the number of epochs vs error
figure
plot(epochsError);
legend('Error')
title('Error vs Number of Epochs');

