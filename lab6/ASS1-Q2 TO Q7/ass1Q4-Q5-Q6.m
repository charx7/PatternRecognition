% clear console
clc;
clear;

disp('ill be k means weeee');

% Load data
load = load('kmeans1.mat');
dataMat = cell2mat(struct2cell(load));

%Init config
kValues = [];
errorList = [];
errorMatrix = [];
kMax = 10;

for i = 1:kMax
    if i == 1
        totalError = 0;
        epochCount = randsample(5:10,1);
        for j = 1:epochCount
            [~, centroids, clusterLabels]  = myKmeans(dataMat, i ,1000);
            % Calculate quantization error
            error = quantization_error(dataMat, centroids, clusterLabels);
            totalError = totalError + error;
        end
        JOneError = totalError/epochCount;
        % Calculate R(k) error
        RError = R_Error(JOneError, 2, i);
        % Calculate D(k) error
        DError = RError/JOneError;

        rowOfErrorMatrix = [i,DError,RError,JOneError];
        errorMatrix = [errorMatrix;rowOfErrorMatrix];
    elseif i ~=1
                totalError = 0;
        epochCount = randsample(5:10,1);
        for j = 1:epochCount
            [~, centroids, clusterLabels]  = myKmeans(dataMat, i ,1000);
            % Calculate quantization error
            error = quantization_error(dataMat, centroids, clusterLabels);
            totalError = totalError + error;
        end
        JError = totalError/epochCount;
        % Calculate R(k) error
        RError = R_Error(JOneError, 2, i);
        % Calculate D(k) error
        DError = RError/JError;

        rowOfErrorMatrix = [i,DError,RError,JError];
        errorMatrix = [errorMatrix;rowOfErrorMatrix];
    end
end

%Plot
[val, maxDErrorIdx] = max(errorMatrix(:,2));
figure
plot(errorMatrix(:,1),errorMatrix(:,2))
text(errorMatrix(maxDErrorIdx,1),errorMatrix(maxDErrorIdx,2),"kOptimum");
title("D(k) error values for different Ks");
legend("D(k) values");

figure
plot(errorMatrix(:,1),errorMatrix(:,3))
hold on
plot(errorMatrix(:,1),errorMatrix(:,4))
text(errorMatrix(maxDErrorIdx,1),errorMatrix(maxDErrorIdx,3),"kOptimum");
text(errorMatrix(maxDErrorIdx,1),errorMatrix(maxDErrorIdx,4),"kOptimum");
line([2 2], get(gca, 'ylim'));
title("R(k) and J(k) error values for different Ks");
legend("R(k)","J(k)");
fprintf("Optimal K value is 2");