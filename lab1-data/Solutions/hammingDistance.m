function [ result ] = hammingDistance( v1, v2)
    %hammingDistaneCalculate the hamming distance of 2 vectors
    %using the xor function
    xorResult = xor(v1, v2);
    % Normalize the vector by dividing by the dimensions
    result = xorResult / 30;
end

