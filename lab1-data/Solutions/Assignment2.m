% Random Integer
rInteger = randi([1 20]);
fprintf('We are choosing the random %d file.\n', rInteger);

% Use the sprintf function to generate the string
fileToLoad = sprintf('person%02d.mat',rInteger); 

% Load the data from the persons file
data = load(fileToLoad);

notReapeated = false;
while notReapeated == false
    % Choose randomly 2 rows
    r1 = randi([1 20]);
    r1 = randi([1 20]);
    if r1 ~= r2
        notReapeated = true;
    else
        notReapeated = false;
    end
end
    
fprintf('The first row index is: %d.\nThe second one is %d. \n',r1,r2);