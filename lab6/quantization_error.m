function error = quantization_error(data, centroids, labels)
    % Init the error at 0
    sum = 0;
    numberOfClusters = length(centroids(:,1));
    for i=1:numberOfClusters
        % Get the points in the ith cluster
        currentDataCluster = data(find(labels == i),:);
        % Calculate its size
        clusterSize = length(currentDataCluster);
        % Sum the error over all the data points inside the cluster
        for j=1:clusterSize
            try 
                sum = sum + (norm(centroids(i,:) -  currentDataCluster(j,:)))^2;
            catch 
                sum = sum;
            end
        end
    end
    sum = sum/2;
    error = sum;
end