function Y = sobel(X)
%
%   Y = sobel(X)
%
%   Smooths the image X by a gaussian filter, and then applies 3x3 sobel
%   edge detector masks on the smoothed image.
%   The magnitude of the edges is stored in the intensity image Y.
%
%   Developed by: Mikel Rodriguez, Vision Lab UCF

w = 5;  % Gaussian filter size (odd), i.e. w x w
sigma = (w/2 - 1)*0.3 + 0.8;    % Standard deviation for Gaussian smoothing filter;
H = fspecial('gaussian', [w w], sigma);
% H = fspecial('average', [w w]);
X = imfilter(X, H, 'replicate');    
X = single(X); % Made 'single', so that next imfilter's output may contain accurate -ve values, too.

Hx = fspecial('sobel');
Hy = Hx';
vEdges = imfilter(X, Hx, 'replicate');
hEdges = imfilter(X, Hy, 'replicate');

% edges1 = sqrt((hEdges.^2) + (vEdges.^2));
Y = abs(hEdges) + abs(vEdges); % Equivalent and efficient
Y = scale(Y, min2(Y), max2(Y), 0, 255);
Y = uint8(Y);

% imshow(Y)
% Y(Y < 40) = 0;
%se = strel('square',5);
% Y = imclose(imopen(Y, se), se);
%Y = imopen(Y, se);