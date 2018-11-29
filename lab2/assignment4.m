clc;

% Random Walk Simulation
numberOfTurns = 100;
walkDimension = 1000;
scores = zeros(1,walkDimension);

for i = 1:numberOfTurns
    for j = 1:walkDimension
        % Simulate a random coin toss
        coinToss = round(rand(1,1));
        if coinToss == 1
            scores(:,j) = scores(:,j) + 1;
        end
    end
end

scores

% Plot the Random walk pdf
figure('Name','Random Walk Density');
hold on;
h1 = histogram(scores,'facecolor','red');
h1.BinWidth  =  4; 
hold off;

% Normal approximation to a binomial dist (sorta)
% The mean is equal to mu = np
theoreticalMean = numberOfTurns*0.5;
% The variance is np(1-p)
theoreticalVar = (numberOfTurns*0.5)*(1 - .05);

% Prints
fprintf('The theoretical mean of the dist is: %f02. \n', theoreticalMean);
fprintf('The theoretical var of the dist is: %f02. \n', theoreticalVar);
