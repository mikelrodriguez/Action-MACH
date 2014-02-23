function c = fftnormxcorr3(I, T)
%
%   c = fftnormxcorr3(I, T)
%
%   Computes normalized correlation between the search video I and
%   template video T. The size of the result c will be "size(I)-size(T)+1".
%   I and T are 3-D arrays, in which each matrix is an image at a
%   particular time sample.
%
%   Mikel Rodriguez, Vision Lab UCF

% If the input videos are not of "double" type, make them "double" type.
if ~isa(I, 'double')
    I = double(I);
end
if ~isa(T, 'double')
    T = double(T);
end
c = fftxcorr3b(I, T, 'valid');
[cRows, cCols, cMatrices] = size(c);

% Normalization of correlation
[TRows, TCols, TMatrices] = size(T);
TVector = T(:);
normT = norm(TVector);
for i = 1 : cRows
%     if rem(i, 1) == 10
%         % percentComplete = 100*i/cRows
%         disp(sprintf('%Completed = %0.2f', i/cRows))
%         % pause(0.001);
%     end
    for j = 1 : cCols
        for k = 1 : cMatrices
            ISection = I(i:i+TRows-1, j:j+TCols-1, k:k+TMatrices-1);
            ISectionVector = ISection(:);
            normISection = norm(ISectionVector);
            if normT ~= 0 && normISection ~= 0
                c(i, j, k) = c(i, j, k) / (normISection * normT);
            elseif (normT == 0 && normISection ~= 0) || (normT ~= 0 && normISection == 0)
                c(i, j, k) = 0;
            else
                c(i, j, k) = 1;
            end
        end
    end
end
