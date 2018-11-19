function [ result ] = hammingDistance( v1, v2)
    %hammingDistaneCalculate the hamming distance of 2 vectors
    %using the xor function
    xorResult = xor(v1, v2);
    % Sum of the XOR resulting vector
    vectorSum = sum(xorResult);
    % Normalize the vector by dividing by the dimensions
    szdim = size(xorResult,2);
    result = vectorSum / szdim;
end

