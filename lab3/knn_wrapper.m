clear all;
clc;
load lab3_2.mat;

K=5;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    % Store the result on a result vector
    result(j,i) = KNN([X Y],K,data,class_labels);
  end
end

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1: 50,1),scaled_data(  1: 50,2),'go');
plot(scaled_data( 51:100,1),scaled_data( 51:100,2),'b+');
plot(scaled_data(101:150,1),scaled_data(101:150,2),'r+');
plot(scaled_data(151:200,1),scaled_data(151:200,2),'cs');

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
