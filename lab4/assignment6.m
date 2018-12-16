clc;
clear;

% Read the images
I = imread('dogGrayRipples.png');

% Transform to double
I = im2double(I);

% Do the fft on 2d
f = fft2(I);

% Log transform
f = log(1+f);

% Shift the transform
fs= fftshift(f);

% Take the abs values
f = abs(fs);

% Show the images
imshow(f,[]);

% Good value for r?
r = 1;
[x, y] = getpts();

% Build a mask 
% construc an empty vector
mask=zeros(size(f));

% Variable inits
rows = size(f,1);
cols = size(f,2);
radius = r;
center = [x; y];  

% Get a meshgrid
[xMat,yMat] = meshgrid(1:cols,1:rows);

for i =1:size(center,2)
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius)=1;
end

% pretty plotz
figure, imshow(~mask,[]);title('Mask')

% Apply the mask and filter the noise

% Show the image
% apply the mask
fs=fs.*(-mask);

% apply the inverse fft
f = ifftshift(fs);

% shift the inverse fft
I = real(ifft2(f));

% Plot
figure, imshow(I, []), title('Reconstructed');



