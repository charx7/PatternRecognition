clc;
clear;

%Store image in img variable 
img = imread('Cameraman.tiff');

%Compute edges with canny algorithm
edges = edge(img,'canny');

%Set theta
theta = -90:1:89;
%thetaInRadians = theta*pi/180;

%first find coordinates that are non-zero in edge-map of the image
[Y,X] = find(edges);

%using equation 1 given for the assignment we compute all possible rho values
%for each X,Y coordinate pairs
rho = round(X*cosd(theta) + Y*sind(theta));

%find largest value in the rho matrix to determine accumulator array's
%dimension
rhoMax = max(rho(:));
rhoRange = -rhoMax-2:1:rhoMax+2;

%initialize accumulator array of zeros
accArray = zeros(length(rhoRange),length(theta));

%repeat row vector "rhoRange" by the row size of rho 
rhoRangeMat = repmat(rhoRange,[size(rho(:),1),1]);

%transpose rho
transRho = rho';

%subtract each calculated rho values from total range and take absolute values 
diffMatrix = abs(rhoRangeMat-transRho(:));

%find where the shortest difference occurs between rho values and rhoRange
[d, indArrRho] = min(diffMatrix,[],2);

angleIndex = repmat((1:length(theta))',[size(indArrRho,1)/length(theta),1]);

for i=1:size(indArrRho,1)
    
    accArray(indArrRho(i),angleIndex(i)) = accArray(indArrRho(i),angleIndex(i)) + 1;
    
end


%original hough function
[hcm,thetaVal,rhoVal] = hough(edges);

%compare accumulator plots
subplot(121);imagesc(hcm, 'Xdata', thetaVal, 'Ydata', rhoVal);title('MATLAB hough function');
subplot(122);imagesc(accArray, 'Xdata', theta, 'Ydata', rhoRange);title('myhough function');
