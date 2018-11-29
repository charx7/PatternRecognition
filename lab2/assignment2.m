clc;

% Declare them as symbolic
syms a b c d
% Get the observations
A = [a b];
B = [c d];

% Join the obs so we have a matrix
matrix = [A;B]

cov(matrix)

% Take the transpose
data = matrix'