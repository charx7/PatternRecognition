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

% Calculate the class conditional means
class1mean = mean(data1mat);
class2mean = mean(data2mat);

% Init prototypes
%prototypes = zeros(3,2);

% Add random noise for each prototype
% Init weights with random noise
prototype1 = class1mean + randn(size(class1mean));
prototype2 = class2mean + randn(size(class2mean));
prototype3 = class1mean + randn(size(class1mean));

% Vectorize
prototypes = [prototype1; prototype2; prototype3];

% parameters of the algo
szData = size(fullData);
numberOfExamples = szData(1);
learningRate = 0.01; 
epochs = 1;
for j = 1:epochs
    % Do the loop for the number of epochs
    for i = 1:numberOfExamples
        % Get the current Point
        currentPoint = fullData(i,:);
        % Calculate the distances
        currentDistance = pdist2(currentPoint, prototypes,'euclidean');
        % Square the dist measure
        currentDistanceSquare = currentDistance.^2;
        % Calculate the min
        [currentMin minIdx] = min(currentDistanceSquare);

        % Update the positions of the prototypes based on the winner 
        % Get the winner closer
        prototypes(minIdx, :) = prototypes(minIdx, :) + learningRate*currentPoint;
        % Get the loosers further away
        prototypes([1:minIdx-1 minIdx+1:end],:) = prototypes([1:minIdx-1 minIdx+1:end],:) - learningRate*repmat(currentPoint,2,1);

    end
end

plot(prototypes(1,1), prototypes(1,2), 'r*','color','b','MarkerSize',10);
plot(prototypes(2,1), prototypes(2,2), 'r*','color','g','MarkerSize',10);
plot(prototypes(3,1), prototypes(3,2), 'r*','color','r','MarkerSize',10);

hold on




