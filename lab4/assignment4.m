clc;
clear;

%Store image in img variable 
img = imread('HeadTool0002.bmp');

%convert to double precision

Y = double(img);

fprintf('the type of array is: %s \n', class(Y));

%apply CLAHE Method

J = adapthisteq(img,'clipLimit',0.02,'Distribution','rayleigh');

%compare enchanced and non-enhanced

imshowpair(img, J,'montage');


%find 6 circles
[centers, radii, metric] = imfindcircles(J,[15 58]);

%show 6 circles
imshow(J);
viscircles(centers, radii);

%show two strongest circles
imshow(J);
centersStrong5 = centers(1:2,:); 
radiiStrong5 = radii(1:2);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
