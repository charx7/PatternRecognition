clear all;
clc;
load lab3_2.mat;

error_vector = {};
ks = {};
for k = 1:17
    % Change K to use LOOCV
    K=k;
    samples=200;
    data = lab3_2;
    	

    % Class labels
    class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
    for j =1:200
        % Get a copy of the dataset
        newData = data;
        % Remove the jth observation
        newData(j,:) = [];
        % Test on the point we got out of the dataset
        X=data(j,:);
        % Store the result on a result vector
        result(j) = KNN(X, K, newData, class_labels);
    end

    sum = 0;
    for j=1:200
        if class_labels(j) == result(j)
            sum = sum + 1;
        end
    end
    
    % Get the % of incorrect classifications
    incorrect_percent = (200 - sum)/ 200;
    % Store it on an error vector
    error_vector = [error_vector, incorrect_percent];
    ks = [ks, k];
    fprintf('For k = %d \n',k);
    fprintf('The percent of incorrect classifications is: %f \n', incorrect_percent);
end
    
 ks = cell2mat(ks);
 error_vector = cell2mat(error_vector);
 figure;
 plot(ks, error_vector);
 
 
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
