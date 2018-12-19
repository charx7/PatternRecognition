clc;
clear;

% Read the image
c = imread('cameraman.tif');

% Compute the edges
edges = edge(c, 'canny');

% image show to see if it loaded
%imshow(edges);

% Compute the hough transform
[hc, theta, rho] = hough(edges);

% Plot
figure
imagesc(hc, 'Xdata', theta, 'Ydata', rho);
title('s3743071');

hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

figure
imagesc(hc, 'Xdata', theta, 'Ydata', rho);
xlabel('\theta	(degrees)')	
ylabel('\rho')
title('s3743071');
axis on
axis normal
hold on
colormap(hot)

% find the peaks
peaks = houghpeaks(hc,5,'threshold',ceil(0.3*max(hc(:))));

% Superimposition on the HT images	
x	=	theta(peaks(:,2));	
y	=	rho(peaks(:,1));
plot(x,y,'s','color','black');

% Hough line usage
% Get the maximum vector points
maxPeakIndexes = houghpeaks(hc,1,'threshold',ceil(0.3*max(hc(:))));
maxVectorDimTheta	=	theta(maxPeakIndexes(:,2));	
maxVectorDimR	=	rho(maxPeakIndexes(:,1));

% make a new figure
figure
imshow(c);


myhoughline(c,  maxVectorDimR, maxVectorDimTheta); 
title('s3743071');
% for i=1:length(x)
%     myhoughline(c, y(i), x(i));
%     hold on
% end

function myhoughline(image,r,theta)
    [x,y]=size(image);

    angle=deg2rad(theta);
   
    if sin(angle)==0
        line([r r],[0,y],'Color','red')
    else
        line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
    end
    
end