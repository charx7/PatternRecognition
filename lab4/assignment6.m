clc;
clear;

% Read the images
I = imread('dogGrayRipples.png');

% Transform to double
I = im2double(I);

% Do the fft on 2d
f = fft2(I);

% fft shift
fs= fftshift(f);

% Take the abs values
f = abs(fs);

% Log transform
f = log(1+f);

% Show the images
imshow(f,[]);

% Build a mask/ variable inits
rows = size(f,1),cols = size(f,2),radius =10, [x ,y] =getpts; center=[x;y];

% Get a meshgrid
[xMat,yMat] = meshgrid(1:cols,1:rows);

% Initialize the mask as zeros
mask=zeros(size(f));
for i =1:size(center,2)
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(3,i)).^2);
    % Apply the mask
    mask(distFromCenter<=radius)=1;
    
    distFromCenter = sqrt((xMat-center(2,i)).^2 + (yMat-center(4,i)).^2);
    % Apply the mask
    mask(distFromCenter<=radius)=1;
end

% Plot the images
figure,imshow(f,[]); hold on; imshow(~mask,[]);title('Mask')

% Apply the mask
fs=fs.*(~mask);

% Apply a shift to the fft
f = ifftshift(fs);

% Get the real part of the ifft
I = real(ifft2(f));
% Plot the image w/out noise
figure, imshow(I, []), title('s3743071');

