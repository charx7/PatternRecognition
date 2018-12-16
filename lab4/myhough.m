function [accumulator,thetaRange,rhoValues] = myhoughAlt(edgeMap)

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

for i=1:length(X)
   for k =1:length(theta)
        %using equation 1 given for the assignment we compute all possible rho values
        %for each X,Y coordinate pairs
        rho = floor(X(i)*cosd(theta(k)) + Y(i)*sind(theta(k)));
        %subtract each calculated rho values from total range and take absolute
        %values.
        diff = abs((rhoRange-rho)+1);
        %find where the shortest difference occurs between rho values and rhoRange
        [d,rhoIndex] = min(diff,[],2);
        %
        if d == 0
            accArray(rhoIndex,k) = accArray(rhoIndex,k) + 1;
        end
   end    
end

accumulator = accArray;
rhoValues = rhoRange;
thetaRange = theta;

%original hough function
[hcm,thetaVal,rhoVal] = hough(edgeMap);

%compare accumulator plots
subplot(121);imagesc(hcm, 'Xdata', thetaVal, 'Ydata', rhoVal);title('MATLAB hough function');
subplot(122);imagesc(accArray, 'Xdata', theta, 'Ydata', rhoRange);title('myhough function');
end
