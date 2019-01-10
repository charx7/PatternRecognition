% clear console
clc;
clear;

disp('ill be k means weeee');

% Load data
load = load('kmeans1.mat');
dataMat = cell2mat(struct2cell(load));

%init parameters
szData = size(dataMat);
numberOfExamples = szData(1);
k = 2;
centroids = [];
clusterLabels = zeros(numberOfExamples,1);
maxEpochs = 1000;

% take random samples from the data set
for i=1:k
    rng(41 + i)
    randomIndex = randsample(numberOfExamples,1);
    randomPoint = dataMat(randomIndex,:);
    centroids = [centroids; randomPoint];
end
% Must save for the arroz plotz
initialCentroids = centroids;

% Epochs loop
for j=1:maxEpochs
    % Assign data points to the nearest cluster
    for i=1:numberOfExamples
        % Get the current Point
        currentPoint = dataMat(i,:);
        % Calculate the distances
        currentDistance = pdist2(currentPoint, centroids(:,1:2),'euclidean');
        % Calculate the min
        [currentMin, minIdx] = min(currentDistance);
        % Assign the cluster to the min distance
        clusterLabels(i,1) = minIdx;
    end

    % Re compute the centroids as the mean of the points assigned to each
    % cluster
    % Old centroids as a stop condition for algo
    oldCentroids = centroids;
    for i=1:k
        % Find the indexes where we have the current cluster assign
        currentCentroidIndexes = find(clusterLabels == i);
        % Get the points
        currentCentroidPoints = dataMat(currentCentroidIndexes,:);
        % Recompute the centroid as the mean of the assigned points :D
        newCentroid = mean(currentCentroidPoints);
        % Re-assign the current centroid as the mean
        centroids(i,:) = newCentroid;
    end
    
    if abs(norm(oldCentroids) - norm(centroids))< 0.01
        % Escape the loop
        break
    end
end

colorz = ['r','g','b','c','m','y','k','w'];
% Plotz for dayz
for p=1:size(centroids,1)
    plot(centroids(p,1), centroids(p,2), '-o','MarkerSize',10, 'MarkerFaceColor', colorz(p));
    % Plot arrows
    hold on
end
% Scatter Plot of the dataz
scatterData = [[dataMat] clusterLabels];
x1 = scatterData(:,1);
x2 = scatterData(:, 2);
classes = scatterData(:,3);
scatter(x1(classes == 1), x2(classes == 1))
hold on;
scatter(x1(classes == 2), x2(classes == 2))
hold on

legend('centroid1','centroid2','Cluster1','Cluster2')
for p=1:size(centroids,1)
    plot_arrow(initialCentroids(p,1),initialCentroids(p,2),centroids(p,1),centroids(p,2));
    
    hold on
end
title('Scatter Plot of k=2');
