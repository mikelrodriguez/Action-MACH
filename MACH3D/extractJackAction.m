
close all
clear all;
clc;

inFile = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\jack\shahar_jack.avi';
outFile = 'jack_009.avi';    % Action_Actor, where 1_1 means Bend_Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 19; % Daria = 8, Denis = 1, eli =9 , ido = 1, ira = 17, lena = 22 , lyoa=21, moshe =22 ,shahar=19;
finalFrame = startingFrame + 30 - 1; % 30 frames for every example

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);
    rgbImage = frame.cdata;
    bri = 111;
    brj = 105;
    % width=68 and height= 98 for all; bri and brj are different, as below:
    % Daria(bri=126, brj=89); Denis(122,102); eli(110,116);  ido(,); ira(125,116); lena(113,117); lyova(124,100); moshe(113,113);shahar(111,105) 
    rgbSection = rgbImage(bri-98+1:bri, brj-68+1:brj, :);%88
    
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
    