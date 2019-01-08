
clc;
clear;
close all;

% Load dataz
load1 = load('data_lvq_A.mat');
load2 = load('data_lvq_B.mat');

%Convert to matrix
data1mat = cell2mat(struct2cell(load1));
data2mat = cell2mat(struct2cell(load2));

% Add labels
class1 = zeros(200,1);
class2 = ones(200,1);

% Join data
fullData = [data1mat; data2mat];

numberOfClasses = 2;

% Scatter plot
figure
scatter(data1mat(:,1), data1mat(:,2));
hold on
scatter(data2mat(:,1), data2mat(:,2));
title('Scatter Plot of 2 classes');
hold on

% Class labels
class_labels = floor( (0:length(fullData)-1) * numberOfClasses / length(fullData) );

% Calculate the class conditional means and fullData mean
class1mean = mean(data1mat);
class2mean = mean(data2mat);
fullDataMean = mean(fullData);

rng(42)
%Prepare prototypes for question 1 - 4
prototype1 = class1mean + randn(size(class1mean));
prototype2 = class1mean + randn(size(class1mean));
prototype3 = class2mean + randn(size(class2mean));
prototype4 = class2mean + randn(size(class2mean));

% Vectorize
prototypes = [prototype1 0; prototype2 0; prototype3 1];

%Plot for question 4
myRelevanceLVQ(fullData,prototypes,class_labels,0.01,1);
legend('Class 1','Class 2','Prototype 1-A','Prototype 2-A','Prototype 3-B')

figure
subplot(1,2,1);
[Epochcount,epochsError,prototypeList,predictedLabels,lamdas] = myRelevanceLVQ(fullData,prototypes,class_labels,0.01,2);
title('Number of Epochs vs Error');

hold on
% Lambdas Plot
subplot(1,2,2);
plot(lamdas(1,:));
hold on
plot(lamdas(2,:));
legend('lamda1','lamda2');
title('Lambdas across epochs');
%prototype_2to1 = [prototype1 0; prototype2 0; prototype3 1];