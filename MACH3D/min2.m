function [value, row, col] = min2(A)
% 
%       [value, row, col] = min2(A)
%
% Finds the minimum value in matrix A
% Returns value, and its coordinates.
%
%   Mikel Rodriguez, Vision Lab UCF

% 
% [v, ii] = min(A);
% [value, col] = min(v);
% row = ii(col);

[ARows, ACols] = size(A);

A = transpose(A);   % So that the scanning is done row-wise.
[v, jj] = min(A);
[value, row] = min(v);
col = jj(row);

if ACols == 1   % If A is a column vector
    temp = row;
    row = col;
    col = temp;
end