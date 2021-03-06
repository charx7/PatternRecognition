clc;
clear;

disp('ill be k means weeee');

% Load data
load = load('kmeans1.mat');
dataMat = cell2mat(struct2cell(load));
% Call the k means func k=2
[initialCentroids, centroids, clusterLabels]  = myKmeans(dataMat, 2 ,1000);
%[initialCentroids, centroids, clusterLabels]  = k_means_plusplus(dataMat, 2 ,1000);

colorz = ['r','g','b','c','m','y','k','w'];
markerz = ['+','>','o','.', '<','v','d','^'];
% Plotz for dayz
figure
subplot(2,2,1)
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

for p=1:size(centroids,1)
    scatter(x1(classes == p), x2(classes == p), markerz(p));
    hold on;
end
hold off
title('k = 2');

% Call to kmeans for 4k
[initialCentroids, centroids, clusterLabels]  = myKmeans(dataMat, 4 ,1000);
subplot(2,2,2)
% Plotz for dayz k = 4
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
for p=1:size(centroids,1)
    scatter(x1(classes == p), x2(classes == p), markerz(p));
    hold on;
end
hold off
title('k = 4');

% Call to kmeans for 8k
[initialCentroids, centroids, clusterLabels]  = myKmeans(dataMat, 8 ,1000);
subplot(2,2,3)
% Plotz for dayz k = 8
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
for p=1:size(centroids,1)
    scatter(x1(classes == p), x2(classes == p), markerz(p));
    hold on;
end
hold off
title('k = 8');
