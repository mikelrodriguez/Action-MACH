
close all
clear all;
clc;

inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\wave1\shahar_wave1.avi';
outFile = 'wave1_009.avi';    % Action_Actor, where _001 means _Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 1; % Daria =11 , Denis = 1, eli = 32, ido = 1, ira = 1, lena = 29 , lyoa=1, moshe =1 ,shahar=1;
finalFrame = startingFrame + 25 - 1; % 25 frames for every example

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    bri = 119;
    brj = 82;
    % width=48 and height= 90 for all; bri and brj are different, as below:
    % Daria(bri=122, brj=72); Denis(120,83); eli(118,90);  ido(118,85); ira(125,104); lena(123,86); lyova(120,83); moshe(123,87);shahar(119,82) 
    rgbSection = rgbImage(bri-90+1:bri, brj-48+1:brj, :);%88
    
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
    