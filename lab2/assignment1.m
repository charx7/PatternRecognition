% Clean the output of the console
clc;

%create rows to be later merged and transposed into final matrix
A = [4 5 6];
B = [6 3 9];
C = [8 7 3];
D = [7 4 8];
E = [4 6 5];

%merge rows
total = [A;B;C;D;E];

%transpose 
K = total';

%calculate means for each vector
meanF1 = mean(K(1,:));
meanF2 = mean(K(2,:));
meanF3 = mean(K(3,:));

%biased is cov divided by N instead of N-1. N is 5
biasedCovMatrix = (cov(K')*4)/5;

%question 15, 16, 17
pointOne = [5 5 6];
pointTwo = [3 5 7];
pointThree = [4 6.5 1];

% using the pdf
result = mvnpdf([pointOne;pointTwo;pointThree],[meanF1;meanF2;meanF3]',biasedCovMatrix);
