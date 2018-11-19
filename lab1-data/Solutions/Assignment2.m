% Random Integer
rInteger = randi([1 20]);
disp(rInteger);

% Use the sprintf function to generate the string
fileToLoad = sprintf('person%02d.mat',rInteger); 

% Load the data from the persons file
data = load(fileToLoad);