
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
myRelevanceLVQ(fullData,prototypes,class_labels,0.01,2);
title('Number of Epochs vs Error');


%Prepare prototypes lists question 5 - 7
%Init prototypes lists for plotting 4 different combinations of prototype per class
prototype_1to1 = [prototype1 0; prototype3 1];
prototype_1to2 = [prototype1 0; prototype3 1; prototype4 1];
prototype_2to1 = [prototype1 0; prototype2 0; prototype3 1];
prototype_2to2 = [prototype1 0; prototype2 0; prototype3 1; prototype4 1];


%Scatter plot the result of 4 combinations of prototypes for question 6
figure
subplot(2,2,1)
scatter(data1mat(:,1), data1mat(:,2));
hold on
scatter(data2mat(:,1), data2mat(:,2));
title('Scatter Plot of 1to1');
hold on
myRelevanceLVQ(fullData,prototype_1to1,class_labels,0.01,1);
legend('Class 1','Class 2','Prototype 1-A','Prototype 3-A')

subplot(2,2,2)
scatter(data1mat(:,1), data1mat(:,2));
hold on
scatter(data2mat(:,1), data2mat(:,2));
title('Scatter Plot of 1to2');
hold on
myRelevanceLVQ(fullData,prototype_1to2,class_labels,0.01,1);
legend('Class 1','Class 2','Prototype 1-A','Prototype 3-B','Prototype 4-B')

subplot(2,2,3)
scatter(data1mat(:,1), data1mat(:,2));
hold on
scatter(data2mat(:,1), data2mat(:,2));
title('Scatter Plot of 2to1');
hold on
myRelevanceLVQ(fullData,prototype_2to1,class_labels,0.01,1);
legend('Class 1','Class 2','Prototype 1-A','Prototype 2-A','Prototype 3-B')

subplot(2,2,4)
scatter(data1mat(:,1), data1mat(:,2));
hold on
scatter(data2mat(:,1), data2mat(:,2));
title('Scatter Plot of 2to2');
hold on
myRelevanceLVQ(fullData,prototype_2to2,class_labels,0.01,1);
legend('Class 1','Class 2','Prototype 1-A','Prototype 2-A','Prototype 4-B','Prototype 3-B')

%Error plot the result of 4 combinations of prototypes for question 5
figure
subplot(2,2,1)
title('Number of Epochs vs Error - 1to1');
hold on
myRelevanceLVQ(fullData,prototype_1to1,class_labels,0.01,2);

subplot(2,2,2)
title('Number of Epochs vs Error - 1to2');
hold on
myRelevanceLVQ(fullData,prototype_1to2,class_labels,0.01,2);

subplot(2,2,3)
title('Number of Epochs vs Error - 2to1');
hold on
myRelevanceLVQ(fullData,prototype_2to1,class_labels,0.01,2);

subplot(2,2,4)
title('Number of Epochs vs Error - 2to2');
hold on
myRelevanceLVQ(fullData,prototype_2to2,class_labels,0.01,2);
