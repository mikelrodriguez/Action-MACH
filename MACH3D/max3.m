function [cmax, i, j, k] = max3(c);
%
%   [maxc, i, j, k] = max3(c);
%   
%   Computes the maximum value (cmax) in the 3-D array c. It also resturns
%   the row, column, and matrix index of the maximum value (i.e. i, j, and
%   k, respectively.)
%
%   Mikel Rodriguez, Vision Lab UCF

%

[cRows, cCols, cMatrices] = size(c);
ii = zeros(1, cMatrices);
jj = zeros(1, cMatrices);
maxArr = zeros(1, cMatrices);
for k = 1 : cMatrices
    [maxArr(k), ii(k), jj(k)] = max2(c(:,:,k));
end
[cmax k] = max(maxArr);
i = ii(k);
j = jj(k);

