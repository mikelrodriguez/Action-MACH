clc
clear all

% a = [1 2 0; 0 0 0; 0 0 0];
% b = [0 0 0; 0 0 0; 0 0 0];
% b = a(1:2, 2:3, 1:2)

% a = [1 2 3; 4 5 6; 7 8 9];
% a = cat(3, a, a, [0 0 0; 0 0 0; 0 0 0])
% b = a(1:2, 1:2, 1:2)
I = uint8(255*randn(72, 90, 200));
shift = 10;
T = I(1+shift-1:60+shift-1, 1+shift-1:30+shift-1, 1+shift-1:30+shift-1);
tic
c = fftnormxcorr3(I, T);
[cmax, i, j, k] = max3(c)
toc
% a2 = a(2:3,2:3,1:2);
% a2 = a2(:);
% b2 = b(:);
% c111 = sum(a2 .* b2)