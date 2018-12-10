clc;
clear;

% Prameters
mean1 = 5;
mean2 = 7;

var = 4;
sigma = sqrt(var);

% Compute the probabilities
p = normcdf(10,mean2,sigma);
hitProb = 1 - p;

fprintf('The hit probability is: \n');
disp(hitProb);

p = normcdf(10, mean1, sigma);
falseAlarmProb = 1 - p;

fprintf('The miss probability is: \n');
disp(falseAlarmProb);

% discriminability computation
disc = abs(mean2 - mean1) / sigma;
fprintf('The discriminability/sensitivity index is: \n');
disp(disc);

modifiedMean2 = 9;
disc = abs(modifiedMean2 - mean1) / sigma;
fprintf('The second discriminability/sensitivity index is: \n');
disp(disc);

% mean calculation given discriminant
disc = 3;
mean = ((sigma*disc) +  5);
fprintf('The mean given disc = 3 is: \n');
disp(mean);

% Load data
data = load("lab3_1.mat");
% Convert to matrix
matrixData = cell2mat(struct2cell(data));

% Get the matrix dimensions
dimensions = size(matrixData);

% Separate the first and second columns
v1 = matrixData(:,1);
v2 = matrixData(:,2);

% True positives if both are 1
truePositivesVector = and(v1,v2);

% Get the count
truePositivesCount = nnz(truePositivesVector);
% Divide by the total number of trials
truePositives = truePositivesCount / dimensions(:,1);
fprintf('The True positives rate is: %f \n', truePositives);

% True negatives only if both are zero
trueNegativesVector = or(v1,v2);

% Get the count
trueNegativesCount = dimensions(:,1) - nnz(trueNegativesVector);
% Divide by the total number of trials
trueNegatives = trueNegativesCount / dimensions(:,1);
fprintf('The True negatives rate is: %f \n', trueNegatives);
% The count of the false positives
falsePositivesCountPartial = numel(find(v2 == 1));
falseNegativesCountPartial = numel(find(v1 == 1));
falsePositivesCount = falsePositivesCountPartial - truePositivesCount;
falseNegativesCount = falseNegativesCountPartial - truePositivesCount;
% False Positive rate fp / (fp + TN)
falsePositiveRate = falsePositivesCount / (falsePositivesCount + trueNegativesCount);
truePositiveRate = truePositivesCount / (truePositivesCount + falseNegativesCount);

fprintf('The value of the hit rate is: %f \n', truePositiveRate);
fprintf('The value of false alarm rate is: %f \n', falsePositiveRate);

% Construct the ROC curve
space = 0:0.1:20;
tryStd = .947;
X = 1 - normcdf(space, mean1, tryStd);
Y = 1 - normcdf(space, mean2, tryStd);

% Plot
figure;
scatter(falsePositiveRate, truePositiveRate, 8, 'filled');
hold on;
plot(X,Y);

disc2 = abs(mean2 - mean1) / tryStd
 