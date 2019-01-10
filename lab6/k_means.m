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

% take random samples from the data set
for i=1:k
    rng(41 + i)
    randomIndex = randsample(numberOfExamples,1);
    randomPoint = dataMat(randomIndex,:);
    centroids = [centroids; randomPoint];
end

