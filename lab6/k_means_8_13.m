% Clear inputs and vars
clc;
clear;

% Load data
load = load('checkerboard.mat');
dataMat = cell2mat(struct2cell(load));

% Now calculate the error over different K's
ks = [1 2 3 4 5 6 7 8 9 10];
ksError = [];
ksError_plus = [];
quotientFunction = [];
twenty_runsError_kmeans = [];
twenty_runsError_kmeans_plus = [];
% change to 10 after try out with 3 for debugz
for n=1:10
    tic
    disp('Starting trial number: ');
    n 
    for i=1:20
        
        % K-means
        [initialCentroids, centroids, clusterLabels]  = myKmeans(dataMat, 100 ,70);
        % K-means ++
        [initialCentroids_plus, centroids_plus, clusterLabels_plus] = k_means_plusplus(dataMat, 100, 70);
        % Error for k-means
        currentKError = quantization_error(dataMat, centroids, clusterLabels);
        % Error for k-means ++
        currentKError_plus = quantization_error(dataMat, centroids_plus, clusterLabels_plus);
        % Store the error
        ksError = [ksError, currentKError];
        ksError_plus = [ksError_plus, currentKError_plus];
    end
    % get the min out of the 20 runs
    minKmeansError = min(ksError);
    minKmeansPlusError = min(ksError_plus);
    
    if n==1
        twenty_runsError_kmeans = minKmeansError;
        twenty_runsError_kmeans_plus = minKmeansPlusError;
        %twenty_runsRKError = rKError;
    else
        twenty_runsError_kmeans = vertcat(twenty_runsError_kmeans, minKmeansError);
        twenty_runsError_kmeans_plus = vertcat(twenty_runsError_kmeans_plus, minKmeansPlusError);        
        %twenty_runsRKError = vertcat(twenty_runsRKError, rKError);
    end
    % Clean up ksError and ksErrorPlus for later use
    ksError = [];
    ksError_plus = [];
    %minKmeansError = [];
    toc
    %rKError = [];
end

% Calcs for qs 8-13
kMeansMean = mean(twenty_runsError_kmeans)
stdKMeans = std(twenty_runsError_kmeans)
kPlusMean = mean(twenty_runsError_kmeans_plus)
stdKMeansPlus = std(twenty_runsError_kmeans_plus)
% t-test
[h,pValue] = ttest2(twenty_runsError_kmeans, twenty_runsError_kmeans_plus)
