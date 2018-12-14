clc;
clear;

%Store image in img variable 
img = imread('Cameraman.tiff');

%Compute edges with canny algorithm
edges = edge(img,'canny');

%Set theta
theta = -90:1:89;

%Set rho
%first find coordinates that are non-zero in edge-map of the image

[Y,X] = find(edges);

%using equation 1 given for the assignment we compute all possible rho values
%for each X,Y coordinate pairs

rho = round(X*cosd(theta) + Y*sind(theta));

%find largest value in the rho matrix to determine accumulator array's dimension

rhoMax = max(rho(:));

%initialize accumulator array of zeros

accArray = zeros(rhoMax+1,length(theta));

%update accumulator array
