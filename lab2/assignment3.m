clc;

% Store mean vectors and covariance matrix
mu = [3 4];
sigma = [1 0;0 2];

% Set a random seed
rng default  

% Generate a vector of multivariate normal random numbers
randomNumbers = mvnrnd(mu,sigma,100);

% Plot the distribution
x1 = -10:.25:10; 
x2 = -10:.25:10;

% Get a meshgrid of the series
[X1,X2] = meshgrid(x1,x2);

% Calculate the multivariate normal pdf
F = mvnpdf([X1(:) X2(:)],mu,sigma);
% Re-shape so it lookz pretty
F = reshape(F,length(x2),length(x1));

surf(x1,x2,F);

%caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
%axis([-10 10 -10 10 0 .15])
xlabel('x1'); ylabel('x2'); zlabel('Bivariate Normal Density');

% Mahalanobis distance
firstPoint = [10 10];
secondPoint = [0 0];
thirdPoint = [3 4];
fourthPoint = [6 8];

% Compute the inverse of the covariance matrix
sigmaInv = inv(sigma);
MD_to_firstPoint = (firstPoint - mu)* sigmaInv * (firstPoint - mu)';
MD_to_secondPoint = (secondPoint - mu)* sigmaInv * (secondPoint - mu)';
MD_to_thirdPoint = (thirdPoint - mu)* sigmaInv * (thirdPoint - mu)';
MD_to_fourthPoint = (fourthPoint - mu)* sigmaInv * (fourthPoint - mu)';

fprintf('The Md dist to the first point is: %f02. \n',sqrt(MD_to_firstPoint));
fprintf('The Md dist to the second point is: %f02. \n',sqrt(MD_to_secondPoint));
fprintf('The Md dist to the second point is: %f02. \n',sqrt(MD_to_thirdPoint));
fprintf('The Md dist to the second point is: %f02. \n',sqrt(MD_to_fourthPoint));
