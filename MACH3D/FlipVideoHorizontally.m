
close all
clear all;
clc;

% inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\runleft\moshe_runleft.avi';
% outFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\runright\moshe_runright.avi';
inFile = 'D:\Mikel\mFiles\Image Processing\MACH3D\runright_009.avi';
outFile = 'D:\Mikel\mFiles\Image Processing\MACH3D\runleft_009.avi';
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 1;
finalFrame = inFileProp.NumFrames;

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    rgbImage = cat(3, fliplr(rgbImage(:,:,1)), fliplr(rgbImage(:,:,2)), fliplr(rgbImage(:,:,3)));
    
    % Save the frame into a movie
    m = im2frame(rgbImage);
    mov = addframe(mov, m);
    imshow(rgbImage);
    pause(1/FPS);
end
mov = close(mov)
