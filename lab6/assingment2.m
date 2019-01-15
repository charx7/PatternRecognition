% clear console
clc;
clear;

disp('ill be k means weeee');

% Load data and clusters
loadDat = load('checkerboard.mat');
dataMat = cell2mat(struct2cell(loadDat));

%Init
n = 100; %size of prototype list

%Updated prototype lists for different epoch values
[prototypes1] = batchNG(dataMat, n, 20);
[prototypes2] = batchNG(dataMat, n, 100);
[prototypes3] = batchNG(dataMat, n, 200);
[prototypes4] = batchNG(dataMat, n, 500);

%Plot 
figure
subplot(2,2,1)
plot(dataMat(:,1),dataMat(:,2),'bo','markersize',3)
hold on
plot(prototypes1(:,1),prototypes1(:,2),'r.','markersize',10,'linewidth',3)
hold off
subplot(2,2,2)
plot(dataMat(:,1),dataMat(:,2),'bo','markersize',3)
hold on
plot(prototypes2(:,1),prototypes2(:,2),'r.','markersize',10,'linewidth',3)
hold off
subplot(2,2,3)
plot(dataMat(:,1),dataMat(:,2),'bo','markersize',3)
hold on
plot(prototypes3(:,1),prototypes3(:,2),'r.','markersize',10,'linewidth',3)
hold off
subplot(2,2,4)
plot(dataMat(:,1),dataMat(:,2),'bo','markersize',3)
hold on
plot(prototypes4(:,1),prototypes4(:,2),'r.','markersize',10,'linewidth',3)
hold off
