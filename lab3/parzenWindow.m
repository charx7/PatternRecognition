function [result] = parzenWindow(x,p,h)
%calculate parzen window based estimate for probability likelihood  
% x - data points ( has to be inputted as 10 x 3 matrix) 
% h = window size 
% n = no of data points
% p = point ( has to be in the following format u = [0.5;1.0;0] )

%find obs length
n = size(x);
n = n(1);

%transpose datapoint matrix
x = x';

%compute the matrix using parzen window function
parzenWinFuncMat = (-(p-x).^2)/(2*(h^2));

%sum up each values within columns
summedUp = sum(parzenWinFuncMat,1);

%get exp of the summedUp matrix
expMat = exp(summedUp);

%divide by (sqrt(2*pi)*h)^3 which is volume of the hyper cube and the obs
%lenght which is n

normalizedMat = expMat/((sqrt(2*pi)*h)^3*n);


result = sum(normalizedMat(:));

end
