function [ initialCentroids, centroids, clusterLabels ] = myKmeans(data, numberOfClusters, epochsMax)
    % K means function
    %init parameters
    szData = size(data);
    numberOfExamples = szData(1);
    k = numberOfClusters;
    centroids = [];
    clusterLabels = zeros(numberOfExamples,1);
    maxEpochs = epochsMax;
    
    % ----- INIT K++------------------------------
    % Modify the initial centroids from the ++ algo
    % take random samples from the data set
    rng(42)
    randomIndex = randsample(numberOfExamples,1);
    % Choose the point to be random 
    randomPoint = data(randomIndex,:);
    % Not sure if remove XD
    centroids = [centroids; randomPoint];
    D = [];
    for j=1:k
        for i=1:numberOfExamples 
            % Get the current Point
            currentPoint = data(i,:);
            % Calculate the distances
            currentDistance = pdist2(currentPoint, centroids(:,1:2),'euclidean');
            % Calculate the min
            [currentMin, minIdx] = min(currentDistance); 
            % Assign the D matrix the distance squared between a point and its
            % nearest prototype
            D = [D currentMin];
        end
        
    end
    
    % Must save for the arroz plotz
    initialCentroids = centroids;

    % Epochs loop
    for j=1:maxEpochs
        % Assign data points to the nearest cluster
        for i=1:numberOfExamples
            % Get the current Point
            currentPoint = data(i,:);
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
            currentCentroidPoints = data(currentCentroidIndexes,:);
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
    
end
