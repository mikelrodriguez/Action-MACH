function rgbImg = putColorRectangle(img, TLi, TLj, BRi, BRj, lineWidth, color)
% The function:
%
% rgbImg = putColorRectangle(img, TLi, TLj, BRi, BRj, lineWidth, color)
%
% Puts a crosshair of 'chColor' color. Accepts only RGB and gray-level images.
% img: Given image
% lineWidth: Width of the lines of the crosshair
% chColor: 3-element vector [R G B] defining the R, G, and B components of
% the color of the rectangle R, G, & B elements can have any value in the range [0, 255]
% Output image is of type RGB.
%
% Developed by: Mikel Rodriguez, Vision Lab UCF

% TLiOuter = TLi - floor(lineWidth/2);
% TLjOuter = TLj - floor(lineWidth/2);
% BRiOuter = BRi + floor(lineWidth/2);
% BRjOuter = BRj + floor(lineWidth/2);

[rows, cols, dim] = size(img);
if rows > 0 && cols > 0 && isa(img, 'uint8')
    if dim == 3
        % Do nothing, since it is already an RGB image.
    elseif dim == 1
        img = cat(3, img, img, img);
    else
        error('Only gray-level or RGB image is supported');
    end
else
    error('Image should be of size greater than 0-by-0 having type uint8.')
end     

TLiOuter = round(TLi - lineWidth);
TLjOuter = round(TLj - lineWidth);
BRiOuter = round(BRi + lineWidth);
BRjOuter = round(BRj + lineWidth);

[imgRows imgCols dim] = size(img);
tlbr = validateRect(imgRows, imgCols, [TLiOuter TLjOuter BRiOuter BRjOuter]);
TLiOuter = tlbr(1);
TLjOuter = tlbr(2);
BRiOuter = tlbr(3);
BRjOuter = tlbr(4);


chColor = im2uint8(color);
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

% Draw top line
r(TLiOuter : TLiOuter + lineWidth-1, TLjOuter : BRjOuter) = color(1);
g(TLiOuter : TLiOuter + lineWidth-1, TLjOuter : BRjOuter) = color(2);
b(TLiOuter : TLiOuter + lineWidth-1, TLjOuter : BRjOuter) = color(3);

% Draw left line
r(TLiOuter : BRiOuter, TLjOuter  : TLjOuter + lineWidth-1) = color(1);
g(TLiOuter : BRiOuter, TLjOuter  : TLjOuter + lineWidth-1) = color(2);
b(TLiOuter : BRiOuter, TLjOuter  : TLjOuter + lineWidth-1) = color(3);

% Draw bottom line
r(BRiOuter-lineWidth+1 : BRiOuter, TLjOuter  : BRjOuter) = color(1);
g(BRiOuter-lineWidth+1 : BRiOuter, TLjOuter  : BRjOuter) = color(2);
b(BRiOuter-lineWidth+1 : BRiOuter, TLjOuter  : BRjOuter) = color(3);

% Draw right line
r(TLiOuter : BRiOuter, BRjOuter-lineWidth+1  : BRjOuter) = color(1);
g(TLiOuter : BRiOuter, BRjOuter-lineWidth+1  : BRjOuter) = color(2);
b(TLiOuter : BRiOuter, BRjOuter-lineWidth+1  : BRjOuter) = color(3);

rgbImg = cat(3, r, g, b);
