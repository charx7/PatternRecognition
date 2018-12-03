% Clean output of the console
clc;
clear;

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
syms X1 X2
X=[X1,X2];
covMatrix1Inv = inv(covMatrix1);
covMatrix2Inv = inv(covMatrix2);
detCov1 = det(covMatrix1);
detCov2 = det(covMatrix2);

% Now we define the discriminant functions for minimum error rate
g_1 = -(1/2)*(X - muMatrix1)* covMatrix1Inv * transpose((X - muMatrix1)) - (1/2)*log(detCov1) + log(prior1);
g_2 = -(1/2)*(X - muMatrix2)* covMatrix2Inv * transpose((X - muMatrix2)) - (1/2)*log(detCov2) + log(prior2);

% use the expand function to get the quadratic form of the polynomial
g_1Poly = expand(g_1);
g_2Poly = expand(g_2);
fprintf('The first polynomial is: \n');
disp(g_1Poly);

fprintf('The second polynomial is: \n');
disp(g_2Poly);

boundryPoly = expand(g_1 - g_2);
fprintf('The boundry polynomial is: \n');
disp(boundryPoly);

% Solve both functions to get the decision boundary equation
boundryEq = solve((g_1 - g_2) == 0, X2);
%boundryEqPoly = simplify(boundryEq);


% Plot boundary equations graphs
figure('Name','Decision Boundary Plot');
scatter([3,2],[5,1]);
hold on
ezplot(real(boundryEq(1)),[-10 20, -10 20]);
ezplot(real(boundryEq(2)),[-10 20, -10 20]);
