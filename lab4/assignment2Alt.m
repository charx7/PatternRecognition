clc;
clear;

% Read the image
c = imread('cameraman.tif');

% Compute the edges
edges = edge(c, 'canny');

% Compute the hough transform
[hc, theta, rho] = myhough(edges);
% The real ht of matlab
[hcMatlab, thetaMatlab, rhoMatlab] = hough(edges);


% Pretty plotz
figure
subplot(1,2,1);
imagesc(hc, 'Xdata', theta, 'Ydata', rho);
title('My hough');

hold on
subplot(1,2,2);
imagesc(hcMatlab, 'Xdata', thetaMatlab, 'Ydata', rhoMatlab);
title('Matlab Hough');

function [hc, theta, rho] = myhough(edges)
    % Calculate the size of the edges to get the diagonal
    ImSz = size(edges);
    % Get the diagonal
    DiagLen = round(hypot(ImSz(1), ImSz(2)));
    % Which values of theta and rho are we going to use
    thetaValues = -90:1:90;
    rhoValues = -DiagLen:1:DiagLen;
    
    % Initialize accumulator as all zeros
    accumulator = zeros(length(rhoValues), length(thetaValues));
    
    % Loop parameters
    [rows, columns] = size(edges);
    for rows = 1:rows
        xCord = rows;
        for columns = 1:columns
            yCord = columns;
            % Do stuff only for the non-empty pixels
            if edges(xCord, yCord) ~= 0
               
               % Now we go through all the theta and rho we constructed with linspace
               for indexTheta = 1:length(thetaValues)
                   % Transform the angle in radians
                   t = thetaValues(indexTheta);
                   radians = (t*pi)/180;
                   
                   % Calculation of the distance
                   currentRho = yCord*cos(radians) + xCord*sin(radians);
                   currentRho = round(currentRho);
                   % Find the closest Value in the rho array
                   [d, indexRho] = min(abs(rhoValues- currentRho));
                   
                   % Check if <= 1 then add to the accumulator
                   if d<= 1
                       % Cast a vote in the determined closest cell
                       accumulator(indexRho, indexTheta) = accumulator(indexRho, indexTheta) +1;
                   end
               end
            end
        end
    end
    % Start the return values
    hc = accumulator;
    theta = thetaValues;
    rho = rhoValues;
end