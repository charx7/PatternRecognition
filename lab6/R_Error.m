function RError = R_Error(j1Error, dims, k)
    RError = j1Error* k^(-2/dims);
end