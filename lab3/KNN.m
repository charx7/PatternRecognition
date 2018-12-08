function predictedClass = KNN(point , K, data, class_labels)
    % Euclidean distance compute
    distances = pdist2(point, data, 'euclidean');
    % Find the kth smallest elements of the distance vector
    [kth_mins, indexes] = mink(distances, K); 
    % Get the labels
    labels = class_labels(indexes);
    % Get the majority label
    majority_label = mode(labels);
    % Return the majority class (redundant)
    predictedClass = majority_label;
end

