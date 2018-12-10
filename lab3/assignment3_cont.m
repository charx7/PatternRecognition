clc;
clear;

%load data set
cat1 = load("lab3_3_cat1.mat");
cat1 = cat1.x_w1;
cat2 = load("lab3_3_cat2.mat");
cat2 = cat2.x_w2;
cat3 = load("lab3_3_cat3.mat");
cat3 = cat3.x_w3;

% Join to get the data for KNN
data = vertcat(cat1, cat2, cat3);

nr_of_classes = 3;
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data));

%store three points
u = [0.5;1.0;0.0];
v = [0.31;1.51;-0.50];
w = [-1.7;-1.7;-1.7];

% Knn evaluation k = 1
uPointResult1 = KNN(transpose(u), 1, data, class_labels);
vPointResult1 = KNN(transpose(v), 1, data, class_labels);
wPointResult1 = KNN(transpose(w), 1, data, class_labels);

% Knn evaluation k = 5
uPointResult2 = KNN(transpose(u), 5, data, class_labels);
vPointResult2 = KNN(transpose(v), 5, data, class_labels);
wPointResult2 = KNN(transpose(w), 5, data, class_labels);

% Print output
fprintf('Acc to k=1 u corresponds to: %d. \n', uPointResult1);
fprintf('Acc to k=1 v corresponds to: %d. \n', vPointResult1);
fprintf('Acc to k=1 w corresponds to: %d. \n', wPointResult1);

% Print output
fprintf('Acc to k=5 u corresponds to: %d. \n', uPointResult2);
fprintf('Acc to k=5 v corresponds to: %d. \n', vPointResult2);
fprintf('Acc to k=5 w corresponds to: %d. \n', wPointResult2);


