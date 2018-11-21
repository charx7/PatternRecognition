% Load data
data = load("lab1_1.mat");
% Convert to matrix
matrixData = cell2mat(struct2cell(data));
% Calculate corr coef
corrCoef = corrcoef(matrixData);
% Plot the thingy first and the third variables which have a large corr
% Height
x1 = matrixData(:,1);
% Weight
y1 = matrixData(:,end);
figure('Name','Largest');
scatter(x1,y1,'r', 'filled');
% Title of the plot
title('Largest Correlation');
% Axis labels
xlabel('feature1: height');
ylabel('feature2: weight');

% Age
x2 = matrixData(:,2);
% Weight
y2 = matrixData(:,end);
figure('Name','Second Largest');
scatter(x2,y2,'g', 'square', 'filled');
% Title of the plot
title('Second Largest Correlation');
% Axis labels
xlabel('feature1: age');
ylabel('feature2: weight');
