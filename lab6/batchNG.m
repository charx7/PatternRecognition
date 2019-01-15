function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)

% Batch Neural Gas
%   Data contains data,
%   n is the number of clusters,
%   epoch the number of iterations,
%   xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2

%narginchk(3, 5);  % check the number of input arguments
if (nargin<4)
  xdim=1; ydim=2;   % default plot values
end

[dlen,dim] = size(Data);

%prototypes =  % small initial values
% % or
sbrace = @(x,y)(x{y});
fromfile = @(x)(sbrace(struct2cell(load(x)),1));
prototypes=fromfile('clusterCentroids.mat');

lambda0 = n/2; %initial neighborhood value
% lambda
lambda = lambda0 * (0.01/lambda0).^([0:(epochs-1)]/epochs);
% note: the lecture slides refer to this parameter as sigma^2
%       instead of lambda

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Action

    for i=1:epochs
      D_prototypes = zeros(n,dim);   % difference for vectors is initially zero
      D_prototypes_av = zeros(n,1);       % the same holds for the quotients

      for j=1:dlen  % consider all points at once for the batch update
        % sample vector
        x = Data(j,:); % sample vector
        X = x(ones(n,1),:);  % we'll need this

        % find winner prototype for each point based on distance measure
        distanceToClusters = pdist2(x, prototypes, 'euclidean');
        [~, ranks] = sort(distanceToClusters);
      
       %Adaptation 
        for k = 1:size(prototypes,1)
            D_prototypes(ranks(k),:) = D_prototypes(ranks(k),:) + (exp(-k/lambda(i)) * x);
            D_prototypes_av(ranks(k),:) = D_prototypes_av(ranks(k),:) + exp(-k/lambda(k));
        end 
      end
      
      % Update
      for z = 1:size(D_prototypes,1)
        D_prototypes(z,:) = D_prototypes(z,:)/D_prototypes_av(z);
      end
      
      prototypes = D_prototypes;

      % track
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
