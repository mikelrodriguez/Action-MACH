function [cmin, i, j, k] = min3(c);
%
%   [cmin, i, j, k] = min3(c);
%   
%   Computes the minimum value (cmin) in the 3-D array c. It also resturns
%   the row, column, and matrix index of the maximum value (i.e. i, j, and
%   k, respectively.)
%
%   Mikel Rodriguez, Vision Lab UCF

%

[cRows, cCols, cMatrices] = size(c);
ii = zeros(1, cMatrices);
jj = zeros(1, cMatrices);
minArr = zeros(1, cMatrices);
for k = 1 : cMatrices
    [minArr(k), ii(k), jj(k)] = min2(c(:,:,k));
end
[cmin k] = min(minArr);
i = ii(k);
j = jj(k);

