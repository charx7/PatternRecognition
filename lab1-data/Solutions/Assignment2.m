% Clear input
clc;
% Random Integer
rInteger = randi([1 20]);
fprintf('We are choosing the random %d file.\n', rInteger);

% Use the sprintf function to generate the string
fileToLoad = sprintf('person%02d.mat',rInteger); 

% Load the data from the persons file
data = load(fileToLoad);

fprintf('#################\n');
fprintf('Begin Example....\n');
notReapeated = false;
while notReapeated == false
    % Choose randomly 2 rows
    r1 = randi([1 20]);
    r2 = randi([1 20]);
    if r1 ~= r2
        notReapeated = true;
    else
        notReapeated = false;
    end
end
 
% Print for debugz 
%fprintf('The first row index is: %d.\nThe second one is %d. \n',r1,r2);
%fprintf('Selecting....\n');
matrixData = cell2mat(struct2cell(data));

% select first rows from the first randomized vector
firstRow = matrixData(r1,:)
% Select rows form the randomized second vector
secondRow = matrixData(r2,:) 

% Calculate the hamming Distance
hdResult = hammingDistance(firstRow, secondRow);
fprintf('Example hammingDistance is: %d  \n', hdResult);

fprintf('End Example....\n');
fprintf('#################\n');

% ############# Code for the set S ######################
% Results will be saved in this empty vector for vector S
vectorResults = [];
for i = 1:10000
  % Choose a random file
  rInteger = randi([1 20]);
  % Use the sprintf function to generate the string
  fileToLoad = sprintf('person%02d.mat',rInteger); 
  % Load the data from the persons file
  data = load(fileToLoad);
  % Load them into a matrix
  matrixData = cell2mat(struct2cell(data));
  
  notReapeated = false;
  while notReapeated == false
      % Choose randomly 2 rows
      r1 = randi([1 20]);
      r2 = randi([1 20]);
      if r1 ~= r2
          notReapeated = true;
      else
          notReapeated = false;
      end
  end
   
  % Print for debugz 
  %fprintf('The first row index is: %d.\nThe second one is %d. \n',r1,r2);
  %fprintf('Selecting....\n');
  
  % select first rows from the first randomized vector
  firstRow = matrixData(r1,:);
  % Select rows form the randomized second vector
  secondRow = matrixData(r2,:); 

  % Calculate the hamming Distance
  hdResult = hammingDistance(firstRow, secondRow);
  %fprintf('Example hammingDistance is: %d  \n', hdResult);
  % Save the results on the vector
  vectorResults = [vectorResults ; hdResult];
end

% ############# Code for the set D ######################
% Get Data for the set D

vectorResults2 = [];
for i = 1:10000
  notReapeated = false;
  while notReapeated == false
    % Choose randomly 2 rows
    r1 = randi([1 20]);
    r2 = randi([1 20]);
    if r1 ~= r2
      notReapeated = true;
    else
      notReapeated = false;
    end
   end
   
  %fprintf('We are choosing the random %d file.\n', r1);
  %fprintf('We are choosing the random %d file.\n', r2);

  % Use the sprintf function to generate the string
  fileToLoad1 = sprintf('person%02d.mat',r1); 
  fileToLoad2 = sprintf('person%02d.mat', r2);

  % Load files from the random generated numbers
  firstFileData =  load(fileToLoad1);
  secondFileData =  load(fileToLoad2);

  % Convert them into matrix
  matrixData1 = cell2mat(struct2cell(firstFileData));
  matrixData2 = cell2mat(struct2cell(secondFileData));

  % Get a number for the random row of the random files
  randomRow  = randi([1 20]);
  firstRow = matrixData1(randomRow,:);
  secondRow = matrixData2(randomRow,:);
  
  % Calculate HD and save to the vector of results
  hdResult = hammingDistance(firstRow, secondRow);
  vectorResults2 = [vectorResults2 ; hdResult];
  
end

pd1 = fitdist(vectorResults,'Normal');
pd2 = fitdist(vectorResults2,'Normal');

figure('Name','Normal density fit for S and D');
hold on;
histfit(vectorResults,7, 'Normal');
histfit(vectorResults2,10, 'Normal');
hold off;

% Plot the values of the fitted pdf
x_values = 0:.01:.8;
y = (pdf(pd1,x_values))*300;

x1_values = 0:.01:.8;
y2 = (pdf(pd2,x1_values))*300;

% Histogram plotz
binsize = 7;
figure('Name','Histogram of S and D');
hold on;
h1 = histogram(vectorResults,'facecolor','red');
h1.BinWidth  =  0.04; 
plot(x_values,y,'LineWidth',2);

h2 = histogram(vectorResults2,'facecolor','green');
h2.BinWidth  =  0.04;
plot(x1_values,y2,'LineWidth',2);
hold off;

% Computation of the mean and var of the array of S
sMean = mean(vectorResults);
fprintf('The mean of the set S is: %f02. \n', sMean);
sVar = var(vectorResults);
fprintf('The variance of the set S is: %f02. \n', sVar);

% Computation of the mean and var of the array of S
dMean = mean(vectorResults2);
fprintf('The mean of the set D is: %f02. \n', dMean);
dVar = var(vectorResults2);
fprintf('The variance of the set D is: %f02. \n', dVar);

dfS = (dMean *(1- dMean)) / (dVar);
fprintf('The degrees of freedom os D are: %f02. \n', dfS);

criterion = norminv(0.0005, dMean, sqrt(dVar));
fprintf('The criterion C is: %f02. \n', criterion);

p = normcdf(criterion, sMean, sqrt(sVar));
fprintf('The probability of the hamming dist been > Criterion is: %f02. \n',  1-p);

% Calculation of the cutpoint for disctintion of the test person
% Using the calculation for theoretica std for p = 0.5 and n = 20
stdTheoretical = 1/(2*sqrt(20));
hdWithPerson5 = 0.0275002;
cutpoint = normcdf(hdWithPerson5, 0.5, stdTheoretical);
fprintf('The cutpoint is: %d. \n', cutpoint);
