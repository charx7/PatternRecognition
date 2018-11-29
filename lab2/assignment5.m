% Clean output of the console
clc;

% Normal dist parameters
muMatrix1 = [3 5];
muMatrix2 = [2 1];

covMatrix1 = [1 0; 0 4];
covMatrix2 = [2 0; 0 1];

% The prior for N1 will be 0.3 
prior1 = 0.3;
% The prior for N2 will be 0.7
prior2 = 0.7;

% The first function g_i(x) will be 
syms x1 x2 sol
covMatrix1Inv = inv(covMatrix1);
covMatrix2Inv = inv(covMatrix2);
detCov1 = det(covMatrix1);
detCov2 = det(covMatrix2);
X = [x1 x2];

% Now we define the discriminant functions for minimum error rate
g_1 = -(1/2)*(X - muMatrix1)* covMatrix1Inv * transpose((X - muMatrix1)) - (1/2)*log(detCov1) + log(prior1);
% use the expand function to get the quadratic for of the polynomial
g_1Poly = expand(g_1);
fprintf('The first polynomial is: \n');
disp(g_1Poly);

g_2 = -(1/2)*(X - muMatrix2)* covMatrix2Inv * transpose((X - muMatrix2)) - (1/2)*log(detCov2) + log(prior2);


sol=solve(g_1 == g_2, X);
