function [RectTLBR, modCount, modReg] = validateRect(IRows, ICols, RectTLBR)
% 
%   [RectTLBR, modCount, modReg] = validateRect(IRows, ICols, RectTLBR)
%   
%   This function clips the rectangle coordinates vector RectTLBR
%   so that the coordinates of the top-left and bottom-right ponits of
%   the rectangle do not go outside the "IRows x ICols" image.
%   Here, RectTLBR = [TLi, TLj, BRi, BRj]
%   "modCount" is number of modifications, if any coordinate has been modified.
%   modReg = [isTLiMod isTLjMod isBRiMod isBRjMod], each element of which
%   may be 'true', if the corresponding coordinate has been modified.
%


%
TLi = RectTLBR(1);
TLj = RectTLBR(2);
BRi = RectTLBR(3);
BRj = RectTLBR(4);
isTLiMod = 0;
isTLjMod = 0;
isBRiMod = 0;
isBRjMod = 0;

% validate top-left point coordinates

if TLi < 1
    TLi = 1;
    isTLiMod = 1;
end

if TLi > IRows
    TLi = IRows;
    BRi = IRows;
    isTLiMod = 1;
end

if TLj < 1
    TLj = 1;
    isTLjMod = 1;
end

if TLj > ICols
    TLj = ICols;
    BRj = ICols;
    isTLjMod = 1;
end

% Validate bottom-right point coordinates

if BRi < 1
    TLi = 1;
    BRi = 1;
    isBRiMod = 1;
end

if BRi > IRows
    BRi = BRi - (BRi - IRows);
    isBRiMod = 1;
end

if BRj < 1
    TLj = 1;
    BRj = 1;
    isBRjMod = 1;
end

if BRj > ICols
    BRj = ICols;
    isBRjMod = 1;
end
RectTLBR = [TLi TLj BRi BRj];

% Modification statistics
modReg = [isTLiMod isTLjMod isBRiMod isBRjMod];
modCount = sum(modReg);


