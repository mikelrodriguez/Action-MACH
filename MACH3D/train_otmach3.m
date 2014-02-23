function h = train_otmach3(volumes)

% It designs 3-D OT-MACH filter, h, when the training volumes are contained in
% the cell array 'volumes'. Each entry in 'volumes' is actually a
% training volume. The training volumes should be of same size, and for
% good results, the action inside each volume should be at its centre.
%
% Mikel Rodriguez, Vision Lab UCF

[imgRows imgCols timeSamples] = size(volumes{1});
d = imgRows * imgCols * timeSamples;
N = length(volumes);
x = zeros(d, N);
for i = 1 : N
    fft_volume = fft3(double(volumes{i}));
    x(:,i) = fft_volume(:);
end
clear volumes;
mx = mean(x, 2);
c = ones(d,1);  % 2 * ones(d,1);
dx = mean(conj(x) .* x, 2);
temp = x - repmat(mx, 1, N);
sx = mean(conj(temp) .* temp, 2);

alpha = 50;  % 0.05; 1e-3; %0.05; % 0.01;
beta = 1e-12;  % 1e-10 % 1e-15; % 1e-12;    % 0.3
gamma = 1e-12; % 1e-15; % 1e-12;  0.1;
h_den = (alpha * c) + (beta * dx) + (gamma * sx);
h = mx ./ h_den;
h = reshape(h, [imgRows, imgCols, timeSamples]);
h = real(ifft3(h));
h = uint8(scale(h, min3(h), max3(h), 0, 255));

