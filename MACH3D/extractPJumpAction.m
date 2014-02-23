
close all
clear all;
clc;

inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\pjump\shahar_pjump.avi';
outFile = 'pjump_009.avi';    % Action_Actor, where 1_1 means Bend_Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 15; % Daria = 1, Denis = 1, eli = 3, ido = 9, ira = 7, lena =12, lyoa=1, moshe =13 ,shahar=15;
finalFrame = startingFrame + 22 - 1; % 22 frames for every example

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    bri = 120;
    brj = 80;
    rgbSection = rgbImage(bri-100+1:bri, brj-35+1:brj, :);    % width=35 and height= 100 for all; bri and brj ar different; Daria(bri=120, brj=92); Denis(120, 85); eli(120, 92);  ido(120, 91); ira(120, 105); lena(120, 89); lyova(120, 83); moshe(120, 88);shahar(120,80) 
    
    % Save the frame into a movie
    m = im2frame(rgbSection);
    mov = addframe(mov, m);
    imshow(rgbSection);
    if f == startingFrame
        pause;
    else
        pause(0.040);
    end
end
mov = close(mov);

% % Show recorded movie
% close all;
% outFileProp = aviinfo(outFile)
% for f = startingFrame : finalFrame - startingFrame + 1
%     frame = aviread(outFile, f);
%     rgbImage = frame.cdata;
%     imshow(rgbImage);
%     pause(0.040);
%     % pause;
% end
    