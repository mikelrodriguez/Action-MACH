close all
clear all;
clc;

% inFile = 'D:\Mikel\mFiles\Image Processing\MACH3D\bend_001.avi';
% ifp = aviinfo(inFile);
% actionTempl = zeros(ifp.Height, ifp.Width, ifp.NumFrames, 'uint8');
% for f = 1 : ifp.NumFrames
%     frame = aviread(inFile, f);
%     rgbImg = frame.cdata;
%     grayImg = rgb2gray(rgbImg);
%     edgeImg = sobel(grayImg);
%     actionTempl(:,:,f) = edgeImg;
%     imshow(actionTempl(:,:,f));
%     pause(0.040);
% end

load bend_mach.mat;
actionTempl = mach3d;
[ifp.Height, ifp.Width, ifp.NumFrames] = size(mach3d);
figure(1);
for f = 1 : ifp.NumFrames
    imshow(mach3d(:,:,f));
    pause(0.040);
end

% Preparing test video volume
inFileTest = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\bend\daria_bend.avi';
iftp = aviinfo(inFileTest);
volume = zeros(iftp.Height, iftp.Width, iftp.NumFrames, 'uint8');
figure(1),
for f = 1 : iftp.NumFrames
    frame = aviread(inFileTest, f);
    rgbImg = frame.cdata;
    grayImg = rgb2gray(rgbImg);
    edgeImg = sobel(grayImg);
    volume(:,:,f) = edgeImg;
    imshow(volume(:,:,f));
    pause(0.040);
end

% 3-D Template Matching by 3-D Normalized Correlation
tic
c = fftnormxcorr3(volume, actionTempl);
[cmax, i, j, k] = max3(c)
toc

lineWidth = 4;
color = [255 255 0];
outImage = putColorRectangle(volume(:,:,k), i, j, i+ifp.Height-1, j+ifp.Width-1, lineWidth, color);
figure(2),
imshow(outImage);

