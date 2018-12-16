function [accumulator,thetaRange,rhoValues] = myhough(edgeMap,img)

%Set theta
theta = -90:1:89;
%thetaInRadians = theta*pi/180;

%first find coordinates that are non-zero in edge-map of the image
[Y,X] = find(edgeMap);

%using equation 1 given for the assignment we compute all possible rho values
%for each X,Y coordinate pairs
rho = floor(X.*cosd(theta) + Y.*sind(theta));

%find largest value in the rho matrix to determine accumulator array's
%dimension
rhoMax = max(rho(:));
rhoRange = -rhoMax-1:1:rhoMax+1;

%initialize accumulator array of zeros
accArray = zeros(length(rhoRange),length(theta));

%repeat row vector "rhoRange" by the row size of rho 
rhoRangeMat = repmat(rhoRange,[size(rho(:),1),1]);

%transpose rho
transRho = rho';

%delete variable to free up memory
clear rho

%subtract each calculated rho values from total range and take absolute
%values.
diffMatrix = abs((rhoRangeMat-transRho(:))+1);

%delete variable to free up memory
clear rhoRangeMat
clear transRho

%find where the shortest difference occurs between rho values and rhoRange
[~,indArrRho] = min(diffMatrix,[],2);

%delete variable to free up memory
clear diffMatrix

angleIndex = repmat((1:length(theta))',[size(indArrRho,1)/length(theta),1]);

    for i=1:size(indArrRho,1)
    
        accArray(indArrRho(i),angleIndex(i)) = accArray(indArrRho(i),angleIndex(i)) + 1;
    
    end

accumulator = accArray;
rhoValues = rhoRange;
thetaRange = theta;

%original hough function
[hcm,thetaVal,rhoVal] = hough(edgeMap);

%compare accumulator plots
subplot(2,2,1);imagesc(hcm, 'Xdata', thetaVal, 'Ydata', rhoVal);title('MATLAB hough function');
subplot(2,2,2);imagesc(accArray, 'Xdata', theta, 'Ydata', rhoRange);title('myhough function');

%plot the found lines on images
subplot(2,2,3); imshow(img); title('Input Image');

P = houghpeaks(accumulator,5,'threshold',ceil(0.3*max(accumulator(:))));
lines = houghlines(edgeMap,thetaRange,rhoValues,P,'FillGap',5,'MinLength',7);

subplot(2,2,4); imshow(img), hold on

title('Lines found with myhough function');
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

        % Determine the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
    end

end
