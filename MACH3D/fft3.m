function X = fft3(x, siz)
%
%   X = fft3(x)
%   X = fft3(x, siz)
%
%   Calculates 3-D FFT of the 3-D array x, using 1-D FFT.
%   "siz" is a 3-element vector, i.e. [prows pcols pmatrices].
%   If "siz" is provided, the x matrix will be padded by zeros to make it of
%   size prows x pcols x pmatrices before its FFT is calculated and the
%   result will be of the size prows x pcols x pmatrices.
%   If "siz" is not provided, the result will be of same size as that of
%   "x".
%   Class support for input x:
%      float: double, single
%
%   Mikel Rodriguez, Vision Lab UCF

%

if nargin == 2
    prows = siz(1);
    pcols = siz(2);
    pmatrices = siz(3);
else
    prows = [];
    pcols = [];
    pmatrices = [];
end

% X = fft(x, pcols, 2);       % 1-D FFT of each row
% X = fft(X, prows, 1);       % 1-D FFT of each resulting column
% X = fft(X, pmatrices, 3);   % 1-D FFT of each pixel-line along time

X = fft(fft(fft(x, pcols, 2), prows, 1), pmatrices, 3);
