clc;
clear;

%Store image in img variable 
img = imread('Cameraman.tiff');

%Compute edges with canny algorithm
edges = edge(img,'canny');

%Call myhough function
[accumulator,thetaRange,rhoValues] = myhough(edges,img);
