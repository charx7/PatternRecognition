% Clean Console
clc;
% Load test person data
fileToLoad = 'testperson.mat'; 

% Load the data from the persons file
data = load(fileToLoad);
matrixTestPerson = cell2mat(struct2cell(data));
  
fprintf('#################\n');
fprintf('Begin Test Person....\n');

missingBits = sum(matrixTestPerson(:) == 2);

% Start computation of hamming distances for test person and each person
% value

vectorResults = [];
for j = 1:20
    % Use the sprintf function to generate the string
    fileToLoad = sprintf('person%02d.mat',j); 
    % Load the data from the persons file
    data = load(fileToLoad);
    % Load them into a matrix
    matrixCurrentData = cell2mat(struct2cell(data));
    partialResults = [];
    j
    for i = 1:20  
      % Select a row from the dataz
      currentRow = i;
      currentIrisCode = matrixCurrentData(currentRow,:);
      % Calculate HD for the current person
      currentHD = hammingDistanceWithMissing(matrixTestPerson, currentIrisCode, missingBits);
      partialResults = [partialResults ; currentHD];
      %fprintf('The HD of person %d is: \n',  i);
      %disp(currentHD);
    end
    vectorResults = [vectorResults partialResults];
end

% Calculate the mean of the HD's to determine which is most likely the true
% one

meanHDs= mean(vectorResults);

fprintf('End Test Person....\n');
fprintf('#################\n');

fprintf('The minimum element of the array of results is: %f2 \n', min(meanHDs));
fprintf('Corresponds to the person %d. \n', find(meanHDs == min(meanHDs)));
