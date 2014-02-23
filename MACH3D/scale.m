function y = scale(x, xMin, xMax, yMin, yMax, yOption)
% y = scale(x, xMin, xMax, yMin, yMax, yOption)
% Scales the value(s) of "x" matrix, vector or scalar linearly, so that the range of its
% value(s) becomes scaled from the range:
% [xMin xMax] to [yMin, yMax], if option = 'include'
% [xMin xMax] to (yMin, yMax), if option = 'exclude'
% In both cases, if the calculated y comes out to be out of its required range,
% then y will be clipped to make it inside its range.
%
% If y = scale(x, xMin, xMax, yMin, yMax), then yOption = 'include' by default.
% If y = scale(x, xMin, xMax), then yMin = 0, yMax = 1, and yOption =
%    'include' by default.
% If y = scale(x), then xMin = min(x(:)), xMax = max(x(:)), yMin = 0, yMax = 1,
%    and yOption = 'include' by default.
%  
% Developed by: Mikel Rodriguez, Vision Lab UCF

n = nargin; % Number of input arguments
if ~isa(x, 'double')
    x = double(x);
end

switch (n)
    case 1
        xMin = min(x(:));
        xMax = max(x(:));
        yMin = 0;
        yMax = 1;
        yOption = 'include';
    case 3
        yMin = 0;
        yMax = 1;
        yOption = 'include';
    case 5
        yOption = 'include';
    case 6
        % All the four arguments have been passed.
    otherwise
        error('The number of input arguments should be 1, 3, 5, or 6.');
end

switch (yOption)
    case 'include'
        % yMin and yMax are taken as given or mentioned above    
    case 'exclude'
        % Magnitude (absolute value) of yMin and yMax are a little reduced.
        yMin = yMin - sign(yMin) * 1e-4;
        yMax = yMax - sign(yMax) * 1e-4;
    otherwise
        error('The input argument "option" should be ''inculde'' or ''exclude''! ');
end

% Apply straight line equation, when two points (xMin, yMin) & (xMax, yMax)
% are given.
y = ((x - xMin)/(xMax - xMin + eps))*(yMax - yMin) + yMin;  % 'eps' is used to avoid 'divide-by-zero error'.
% Clip value(s) of y, if it/they is/are out of its required range
y(y < yMin) = yMin;
y(y > yMax) = yMax;