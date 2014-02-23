function [value, row, col] = max2(A)
% 
%       [value, row, col] = max2(A)
%
% Finds the maximum value in matrix A
% Returns value, and its coordinates.
%
%   Mikel Rodriguez, Vision Lab UCF

% [v, ii] = max(A);
% [value, col] = max(v);
% row = ii(col);

[ARows, ACols] = size(A);

A = transpose(A);   % So that the scanning is done row-wise.
[v, jj] = max(A);
[value, row] = max(v);
col = jj(row);

if ACols == 1   % If A is a column vector
    temp = row;
    row = col;
    col = temp;
end