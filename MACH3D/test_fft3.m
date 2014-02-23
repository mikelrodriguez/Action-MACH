% Computation of 2-D FFT using 1-D FFT
clc
clear all;
a = ones(4,3);
% a = [1 2 3; 4 5 6; 7 8 9];
b = a;
c = a;
d = a;
e = a;
abc = cat(3, a, b, c, d, e);
prows = 256;
pcols = 256;
pmatrices = 64;


tic
result = fftn(abc, [prows, pcols, pmatrices]); % , [5 4 6])
time1 = toc

tic
result2 = fft3(abc, [prows, pcols, pmatrices]);
time2 = toc

mse = mean((abs(result(:))-abs(result2(:))).^2)