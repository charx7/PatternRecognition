function [ result ] = hammingDistanceWithMissing(v1, v2, numberMissingBits)
    %hammingDistaneCalculate the hamming distance of 2 vectors
    %using the xor function
    xorResult = xor(v1, v2);
    % Sum of the XOR resulting vector
    vectorSum = sum(xorResult);
    % Adjust the vector sum with the number of missing bits
    vectorSum = vectorSum - numberMissingBits;
    % Normalize the vector by dividing by the dimensions
    szdim = size(xorResult,2);
    % Adjust the normalizin factor by the number of missing bits
    szdim = szdim - numberMissingBits;
    % Calculate Result
    result = vectorSum / szdim;
    % If condition
    if result < 0 
        result = 0;
    end
end
