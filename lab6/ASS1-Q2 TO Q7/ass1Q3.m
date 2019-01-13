% clear console
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
scatter(x1(classes == 1), x2(classes == 1))
hold on;
scatter(x1(classes == 2), x2(classes == 2))
hold on

legend('centroid1','centroid2','Cluster1','Cluster2','AutoUpdate','off');
for p=1:size(centroids,1)
    plot_arrow(initialCentroids(p,1),initialCentroids(p,2),centroids(p,1),centroids(p,2));
    
    hold on
end
hold off
title('Scatter Plot of k=2');


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
scatter(x1(classes == 1), x2(classes == 1))
hold on;
scatter(x1(classes == 2), x2(classes == 2))
hold on
scatter(x1(classes == 3), x2(classes == 3))
hold on
scatter(x1(classes == 4), x2(classes == 4))
hold on

legend('centroid1','centroid2','centroid3','centroid4','Cluster1','Cluster2','Cluster3','Cluster4','AutoUpdate','off');
for p=1:size(centroids,1)
    plot_arrow(initialCentroids(p,1),initialCentroids(p,2),centroids(p,1),centroids(p,2));
    
    hold on
end
hold off
title('Scatter Plot of k=4');

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
scatter(x1(classes == 1), x2(classes == 1))
hold on;
scatter(x1(classes == 2), x2(classes == 2))
hold on
scatter(x1(classes == 3), x2(classes == 3))
hold on
scatter(x1(classes == 4), x2(classes == 4))
hold on
scatter(x1(classes == 5), x2(classes == 5))
hold on
scatter(x1(classes == 6), x2(classes == 6))
hold on
scatter(x1(classes == 7), x2(classes == 7))
hold on

scatter(x1(classes == 8), x2(classes == 8))
hold on
legend('centroid1','centroid2','centroid3','centroid4','centroid5','centroid6','centroid7','centroid8','Cluster1','Cluster2','Cluster3','Cluster4','Cluster5','Cluster6','Cluster7','Cluster8','AutoUpdate','off');
for p=1:size(centroids,1)
    plot_arrow(initialCentroids(p,1),initialCentroids(p,2),centroids(p,1),centroids(p,2));
    hold on
end
hold off
title('Scatter Plot of k=8');