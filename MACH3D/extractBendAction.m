
close all
clear all;
clc;

inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\bend\shahar_bend.avi';
outFile = 'bend_009.avi';    % Action_Actor, where 1_1 means Bend_Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 2; % Daria = 5, Denis = 1, eli = 1, ido = 1, ira = 10, lyoa=4, moshe = 2,shahar=2;
finalFrame = startingFrame + 60 - 1; % 40;    % Daria = 40;

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    bri = 120;
    brj = 85;
    rgbSection = rgbImage(bri-80+1:bri, brj-44+1:brj, :);    % width=44 and height= 80 for all; bri and brj ar different; Daria(bri=118, brj=75); Denis(118, 85); eli(118, 95);  ido(118, 80); ira(120, 98); lena(119, 88); lyova(119, 96); moshe(119, 88);shahar(120,85) 
    
    % Save the frame into a movie
    m = im2frame(rgbSection);
    mov = addframe(mov, m);
    imshow(rgbSection);
end
mov = close(mov);

% Show recorded movie
close all;
outFileProp = aviinfo(outFile)
for f = startingFrame : finalFrame - startingFrame + 1
    frame = aviread(outFile, f);
    rgbImage = frame.cdata;
    imshow(rgbImage);
    pause(0.040);
    % pause;
end
    