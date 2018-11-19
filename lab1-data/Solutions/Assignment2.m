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
endfor

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
  
endfor

% Histogram plotz
binsize = 10;
figure('Name','Histogram of S and D');
hold on;
hist(vectorResults, binsize, 'FaceColor','r');
hist(vectorResults2, binsize,'FaceColor','g');
hold off;
