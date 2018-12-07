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

logicTest = ((p-x).^2)/(2*h^2) <= 1/2;

total = 0;
for i = 1:n
    if sum(logicTest(:,i)) == 3
        total = total +1;
    end
end

%parzen window estimation
result = (1/n)*(1/((sqrt(2*pi)*h))^3)*exp(-total);

end
