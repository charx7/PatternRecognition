% clear console
clc;
clear;

% Load data and clusters
loadDat = load('checkerboard.mat');
dataMat = cell2mat(struct2cell(loadDat));

%Init
k = 100; %size of prototype list

%Updated prototype lists for different epoch values
%[prototypes1] = batchNG(dataMat, k, 20);

% k-means for 100 clusters
[initialCentroids, centroids, clusterLabels]  = myKmeans(dataMat, 100 ,1000);

% Remove dead clusters
centroids = rmmissing(centroids);

%Plot 
figure
%subplot(2,2,1)
plot(dataMat(:,1),dataMat(:,2),'bo','markersize',3)
hold on
plot(centroids(:,1),centroids(:,2),'r.','markersize',10,'linewidth',3)
title("k-means")
% Teselation
voronoi(centroids(:,1),centroids(:,2));
hold off



