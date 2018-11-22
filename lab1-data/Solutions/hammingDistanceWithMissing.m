function [ result ] = hammingDistanceWithMissing(v1, v2, numberMissingBits)
    %hammingDistaneCalculate the hamming distance of 2 vectors
    % Find the indices where the vector has missing values ie == 2
    notMissingIndices = find(v1 ~= 2);
    % Modify the v1 and v2 vectos to make a valid comparison
    v1NotMissing = v1(:, [notMissingIndices]);
    v2NotMissing = v2(:, [notMissingIndices]);
    
    %using the xor function
    xorResult = xor(v1NotMissing, v2NotMissing);
    % Sum of the XOR resulting vector
    vectorSum = sum(xorResult);
    % Adjust the vector sum with the number of missing bits
    vectorSum = vectorSum;
    % Normalize the vector by dividing by the dimensions
    szdim = size(xorResult,2);
    
    % Calculate Result
    result = vectorSum / szdim;
end
