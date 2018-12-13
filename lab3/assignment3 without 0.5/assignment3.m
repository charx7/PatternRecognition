%ATTENTION====================================================================================
%Data sets have to be in the same directory with the script
%ATTENTION====================================================================================

close all
clear

%load data set
cat1 = load("lab3_3_cat1.mat");
cat1 = cat1.x_w1;
cat2 = load("lab3_3_cat2.mat");
cat2 = cat2.x_w2;
cat3 = load("lab3_3_cat3.mat");
cat3 = cat3.x_w3;

%store three points
u = [0.5;1.0;0.0];
v = [0.31;1.51;-0.50];
w = [-1.7;-1.7;-1.7];

% q1,q2,q3 likelihood
q1 = parzenWindowEst(cat1,u,1);
q2 = parzenWindowEst(cat2,u,1);
q3 = parzenWindowEst(cat3,u,1);

% q4,q5,q6 likelihood
q4 = parzenWindowEst(cat1,v,1);
q5 = parzenWindowEst(cat2,v,1);
q6 = parzenWindowEst(cat3,v,1);

% q7,q8,q9 likelihood
q7 = parzenWindowEst(cat1,w,1);
q8 = parzenWindowEst(cat2,w,1);
q9 = parzenWindowEst(cat3,w,1);

%Priors for w1,w2,w3 classes
[pw1,pw2,pw3] = deal(1/3);

%posteriors q13, q14, q15
evidenceQ1Q2Q3 = q1*pw1 + q2*pw2 + q3*pw3;
q13 = (q1*pw1)/evidenceQ1Q2Q3;
q14 = (q2*pw2)/evidenceQ1Q2Q3;
q15 = (q3*pw3)/evidenceQ1Q2Q3;

%posteriors q16, q17, q18
evidenceQ4Q5Q6 = q4*pw1 + q5*pw2 + q6*pw3;
q16 = (q4*pw1)/evidenceQ4Q5Q6;
q17 = (q5*pw2)/evidenceQ4Q5Q6;
q18 = (q6*pw3)/evidenceQ4Q5Q6;

%posteriors q19, q20, q21
evidenceQ7Q8Q9 = q7*pw1 + q8*pw2 + q9*pw3;
q19 = (q7*pw1)/evidenceQ7Q8Q9;
q20 = (q8*pw2)/evidenceQ7Q8Q9;
q21 = (q9*pw3)/evidenceQ7Q8Q9;


%class 1 2 3 likelihood for h=2 for u
q25class1u = parzenWindowEst(cat1,u,2);
q25class2u = parzenWindowEst(cat2,u,2);
q25class3u = parzenWindowEst(cat3,u,2);

%class 1 2 3 likelihood for h=2 for v
q25class1v = parzenWindowEst(cat1,v,2);
q25class2v = parzenWindowEst(cat2,v,2);
q25class3v = parzenWindowEst(cat3,v,2);

%class 1 2 3 likelihood for h=2 for w
q25class1w = parzenWindowEst(cat1,w,2);
q25class2w = parzenWindowEst(cat2,w,2);
q25class3w = parzenWindowEst(cat3,w,2);

%class 1 2 3 posteriors for h=2 for u
evidenceQ25u = q25class1u*pw1 + q25class2u*pw2 + q25class3u*pw3;
q25posteriorclass1u = (q25class1u*pw1)/evidenceQ25u;
q25posteriorclass2u = (q25class2u*pw2)/evidenceQ25u;
q25posteriorclass3u = (q25class3u*pw3)/evidenceQ25u;

%class 1 2 3 posteriors for h=2 for v
evidenceQ25v = q25class1v*pw1 + q25class2v*pw2 + q25class3v*pw3;
q25posteriorclass1v = (q25class1v*pw1)/evidenceQ25v;
q25posteriorclass2v = (q25class2v*pw2)/evidenceQ25v;
q25posteriorclass3v = (q25class3v*pw3)/evidenceQ25v;

%class 1 2 3 posteriors for h=2 for w
evidenceQ25w = q25class1w*pw1 + q25class2w*pw2 + q25class3w*pw3;
q25posteriorclass1w = (q25class1w*pw1)/evidenceQ25w;
q25posteriorclass2w = (q25class2w*pw2)/evidenceQ25w;
q25posteriorclass3w = (q25class3w*pw3)/evidenceQ25w;


%questions starting with q28

% Join to get the data for KNN
data = vertcat(cat1, cat2, cat3);

nr_of_classes = 3;
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data));

% Knn evaluation k = 1
uPointResult1 = KNN(transpose(u), 1, data, class_labels);
vPointResult1 = KNN(transpose(v), 1, data, class_labels);
wPointResult1 = KNN(transpose(w), 1, data, class_labels);

% Knn evaluation k = 5
uPointResult2 = KNN(transpose(u), 5, data, class_labels);
vPointResult2 = KNN(transpose(v), 5, data, class_labels);
wPointResult2 = KNN(transpose(w), 5, data, class_labels);


%print input results
fprintf('q1 is: %f02. \n', q1);
fprintf('q2 is: %f02. \n', q2);
fprintf('q3 is: %f02. \n', q3);
fprintf('q4 is: %f02. \n', q4);
fprintf('q5 is: %f02. \n', q5);
fprintf('q6 is: %f02. \n', q6);
fprintf('q7 is: %f02. \n', q7);
fprintf('q8 is: %f02. \n', q8);
fprintf('q9 is: %f02. \n', q9);
fprintf('q10 is: %f02. \n', pw1);
fprintf('q11 is: %f02. \n', pw2);
fprintf('q12 is: %f02. \n', pw3);
fprintf('q13 is: %f02. \n', q13);
fprintf('q14 is: %f02. \n', q14);
fprintf('q15 is: %f02. \n', q15);
fprintf('q16 is: %f02. \n', q16);
fprintf('q17 is: %f02. \n', q17);
fprintf('q18 is: %f02. \n', q18);
fprintf('q19 is: %f02. \n', q19);
fprintf('q20 is: %f02. \n', q20);
fprintf('q21 is: %f02. \n', q21);

%print multiple choice
fprintf('q22 is: %s. \n', "B");
fprintf('q23 is: %s. \n', "B");
fprintf('q24 is: %s. \n', "A");
fprintf('q25 is: %s. \n',"B");
fprintf('q26 is: %s. \n', "B");
fprintf('q27 is: %s. \n', "B");

% Print output
fprintf('Acc to k=1 u corresponds to: %d. \n', uPointResult1);
fprintf('Acc to k=1 v corresponds to: %d. \n', vPointResult1);
fprintf('Acc to k=1 w corresponds to: %d. \n', wPointResult1);

% Print output
fprintf('Acc to k=5 u corresponds to: %d. \n', uPointResult2);
fprintf('Acc to k=5 v corresponds to: %d. \n', vPointResult2);
fprintf('Acc to k=5 w corresponds to: %d. \n', wPointResult2);
