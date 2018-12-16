clc;
clear;

%Store image in img variable 
img = imread('HeadTool0002.bmp');

%convert to double precision
Y = im2double(img);

fprintf('the type of array is: %s \n', class(Y));

%apply CLAHE Method

J = adapthisteq(Y,'clipLimit',0.02,'Distribution','rayleigh');

%compare enchanced and non-enhanced

%imshowpair(img, J,'montage');

%find 6 circles
[centers, radii, metric] = imfindcircles(J,[20 40], 'Sensitivity', 0.9);

%show 6 circles
figure
imshow(J);
viscircles(centers(:,:), radii(:), 'EdgeColor', 'b');

%show two strongest circles
figure
imshow(J);
% New vector
circlesVector = [centers radii];
% sort
sortedCirclesVector = sortrows(circlesVector, 3, 'desc');

centersStrong5 = sortedCirclesVector(1:2,1:2); 
radiiStrong5 = sortedCirclesVector(1:2,3);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
