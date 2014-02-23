function rgbImg = putColorCrossHair(img, imgType, ci, cj, chWidth, chHeight, lineWidth, chColor)
% The function:
%
% rgbImg = putColorCrossHair(I, imgType, ci, cj, chWidth, chHeight, lineWidth, chColor)
%
% Puts a crosshair of 'chColor' color. Supports binary, graylevel, and RGB images.
% img: Given image
% imgType: Type of 'img' image (e.g. 'binary', 'gray', or 'rgb') 
% ci, cj: Row and column of the centre pixel of cross hair
% chWidth: Crosshair width
% chHeight: Crosshair height
% lineWidth: Width of the lines of the crosshair
% chWidth, chHeight, and lineWidth must be odd numbers!
% chColor: 3-element vector [R G B] defining the R, G, and B components of the color of the crosshair
%          R, G, & B elements can have any value in the range [0, 255]
% Output image is of type RGB.
%
% Developed by: Mikel Rodriguez, Vision Lab UCF

if (mod(chWidth,2)==0) || (mod(chHeight,2)==0) || (mod(lineWidth,2) == 0)
    error('chWidth, chHeight, and lineWidth must be odd numbers!');
end
chColor = im2uint8(chColor);
% bw = isbw(img);
% graylevel = isgray(img);
% rgb = isrgb(img);

horizLineTopLeft = round([ci-(lineWidth-1)/2, cj-(chWidth-1)/2]);   
vertLineTopLeft  = round([ci-(chHeight-1)/2 , cj-(lineWidth-1)/2]);

% Make the indeces within the range of the size of input
% image (img)
% ======================================================
[numRows numCols d] = size(img);
hiMin = horizLineTopLeft(1);
if hiMin < 1
    hiMin = 1;
end

hiMax = horizLineTopLeft(1)+lineWidth-1;
if hiMax > numRows
    hiMax = numRows;
end

hjMin = horizLineTopLeft(2);
if hjMin < 1
    hjMin = 1;
end

hjMax = horizLineTopLeft(2)+chWidth-1;
if hjMax > numCols
    hjMax = numCols;
end

viMin = vertLineTopLeft(1);
if viMin < 1
    viMin = 1;
end

viMax = vertLineTopLeft(1)+chHeight-1;
if viMax > numRows
    viMax = numRows;
end

vjMin = vertLineTopLeft(2);
if vjMin < 1
    vjMin = 1;
end

vjMax = vertLineTopLeft(2)+lineWidth-1;
if vjMax > numCols
    vjMax = numCols;
end

% Sense the type of input image and convert it to RGB image
% =========================================================
switch (imgType)
    case 'bw'
        rgbImg = bw2rgb(img);
    case 'gray'
        rgbImg = gray2rgb(img);
    case 'rgb'
        rgbImg = im2uint8(img);
    otherwise
        error('Only binary and gray-level images are supported. Sorry!');
end

% Extract the horizontal-line and vertical-line sections from RGB image
% =====================================================================
horizLineImg = rgbImg(hiMin : hiMax, hjMin : hjMax, :);
vertLineImg  = rgbImg(viMin : viMax, vjMin : vjMax, :);

% Fill the cross-hair area with given color
horizLineImg(:,:,1) = chColor(1);
horizLineImg(:,:,2) = chColor(2);
horizLineImg(:,:,3) = chColor(3);
vertLineImg(:,:,1) = chColor(1);
vertLineImg(:,:,2) = chColor(2);
vertLineImg(:,:,3) = chColor(3);

% Superimpose the colored cross-hair area onto that of RGB image
rgbImg(hiMin : hiMax, hjMin : hjMax, :) = horizLineImg;
rgbImg(viMin : viMax, vjMin : vjMax, :) = vertLineImg;
