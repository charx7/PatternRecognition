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

% Class labels
class_labels = floor( (0:length(fullData)-1) * numberOfClasses / length(fullData) )';

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


%Create folds for CV
k = 10;
cv = cvpartition(class_labels,'k',10);

%find loc
%location=find(cv==k);

% Check whether 10 folds have equal number of classes - Taken from mathworks
%website
for i = 1:cv.NumTestSets
    disp(['Fold ',num2str(i)])
    testClasses = class_labels(cv.test(i));
    [C,~,idx] = unique(testClasses);
    C % Unique classes
    nCount = accumarray(idx(:),1) % Number of instances for each class in a fold
end


%Create error list to store classification errors
errorList = [];

%Employ cv for LVQ1
for i=1:10
    %find test indices
    testIdx = cv.test(i);
    %obtain test set
    testSet = fullData(testIdx,:);
    %find classlabels of train set
    testSetLabels = class_labels(testIdx,:);
    
    %find train indices
    trainIdx = cv.training(i);
    %obtain train set
    trainSet = fullData(trainIdx,:);
    %find classlabels of train set
    trainSetLabels = class_labels(trainIdx,:);
    
    %train LVQ1 with training set and output updated prototype list
    [~,~,prototypeList,~] = myLVQ1(trainSet,prototypes,trainSetLabels,0.01);
    
    %update prototype list to use for next iteration
    prototypes = prototypeList;

    %use LVQ1 model to predict labels for test set
    [~,~,~,predictedLabels] = myLVQ1(testSet,prototypes);
    
    
    %compare the labels of hold-out set with predicted labels
    commonLabelsIdx = find(testSetLabels == predictedLabels);
    
    %calculate the error
    error = 1-size(commonLabelsIdx,1)/size(testSet,1);
    
    %store errors
    errorList = [errorList;error];
end

%plotting
meanError = mean(errorList);
errorList = errorList';

figure
bar(errorList);
text(2.5,0.6,sprintf('mean error value is: %f', meanError),'Color','red','FontSize',12)
hold on
text(1:length(errorList),errorList,num2str(errorList'),'vert','bottom','horiz','center'); 
xlabel("fold in cross-validation");
ylabel("error on test sets");
title("results of 10-fold cross-validation");
plot(xlim,[meanError meanError], 'r')
ylim([0 1])
