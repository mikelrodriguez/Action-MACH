% Computation of 2-D FFT using 1-D FFT

a = [ 1 2 3; 4 5 6; 7 8 9];
% a = [1 1 1; 1 1 1; 1 1 1];
a_fft2_direct = fft2(a)

% fft_of_first_row = fft(a(1,:))

a_fft1_r = fft(a, [], 2); % 1-D FFT of each row
a_fft2_indirect = fft(a_fft1_r, [], 1) % 1-D FFT of each resulting column



