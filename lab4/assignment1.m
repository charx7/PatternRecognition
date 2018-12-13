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

hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

imagesc(hc, 'Xdata', theta, 'Ydata', rho);
xlabel('\theta	(degrees)')	
ylabel('\rho')
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
strongestLine = myhoughline(c, 

function myhoughline(image,r,theta)
    [x,y]=size(image);

    angle=pi*(181-theta)/180;
    
    if sin(angle)==0
        line([r r],[0,y],'Color','red')
    else
        line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
    end
    
end