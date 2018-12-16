clc;
clear;

% Read the image
I  = rgb2gray(imread('chess.jpg'));

% do edges
BW = edge(I,'canny');
% run he ht
[H,T,R] = hough(BW);

% Get the hough peaks
P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:)))); 

% X and Y coordinates
x = T(P(:,2));
y = R(P(:,1));

% Plot
figure
imagesc(H, 'Xdata', T, 'Ydata', R);
hold on
colormap(hot)

% Plot them peak points
plot(x,y,'s','color','white');


figure
% Show the original image
imshow(I);
hold on 
% Plot all dem lines in dem image
for i=1:length(x)
    myhoughline(I, y(i), x(i));
    hold on
end

% hough line function
function myhoughline(image,r,theta)
    [x,y]=size(image);

    angle=deg2rad(theta);
   
    if sin(angle)==0
        line([r r],[0,y],'Color','red')
    else
        line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
    end
    
end