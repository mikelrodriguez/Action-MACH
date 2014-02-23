clc
clear all

a = [1 2 0; 0 0 0; 0 0 0];
b = [0 0 0; 0 0 0; 0 0 0];
a = cat(3, a, a, b)
b = a(1:2, 2:3, 1:2)
d = fftxcorr3(a, b, 'valid')

a2 = a(2:3,2:3,1:2);
a2 = a2(:);
b2 = b(:);
c111 = sum(a2 .* b2)