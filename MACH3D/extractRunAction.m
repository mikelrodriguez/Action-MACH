
close all
clear all;
clc;

inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\run\shahar_run.avi';
outFile = 'run_009.avi';    % Action_Actor, where 1_1 means Bend_Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 1; % Daria = 1, Denis = 1, eli = 1, ido = 1, ira = 1, lena = 1, lyoa=1, moshe = 3,shahar=1;
finalFrame = startingFrame + 26 - 1; % 26 frames for every example

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    bri = 108;
    brj = 112;
    % width=102 and height= 85 for all; bri and brj are different, as below:
    % Daria(bri=120, brj=162); Denis(120, 160); eli(109, 160);  ido(120,130); ira(120, 163); lena(112,144); lyova(120, 128); moshe(109,168);shahar(108,112) 
    rgbSection = rgbImage(bri-85+1:bri, brj-102+1:brj, :);%88
    
    % Save the frame into a movie
    m = im2frame(rgbSection);
    
    
    mov = addframe(mov, m);
    imshow(rgbSection);
    if f == startingFrame
        pause();
    else
        pause(0.2);
    end
end
mov = close(mov)

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
    