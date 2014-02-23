% Computation of 2-D FFT using 1-D FFT
clc
a = ones(4,3);
% a = [1 2 3; 4 5 6; 7 8 9];
b = a;
c = a;
d = a;
e = a;
abc = cat(3, a, b, c, d, e)
result = fftn(abc, [5, 4, 6]) % , [5 4 6])

result1 = fft(abc, 4, 2); % 1-D FFT of each row
result2 = fft(result1, 5, 1); % 1-D FFT of each resulting column
result3 = fft(result2, 6, 3) % 1-D FFT of each corresponding pixel along time
