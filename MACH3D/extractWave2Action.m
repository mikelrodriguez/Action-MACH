
close all
clear all;
clc;

inFile = 'E:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\wave2\shahar_wave2.avi';
outFile = 'wave2_009.avi';    % Action_Actor, where _001 means _Daria.
inFileProp = aviinfo(inFile)
W = inFileProp.Width;
H = inFileProp.Height;
FPS = inFileProp.FramesPerSecond;
numFrames = inFileProp.NumFrames;
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', FPS, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

startingFrame = 17; % Daria = 20, Denis = 13, eli = 1, ido = 1, ira =5, lena = 1 , lyoa=1, moshe = 1,shahar=17;
finalFrame = startingFrame + 28 - 1; % 25 frames for every example

for f = startingFrame : finalFrame
    frame = aviread(inFile, f);jas
    
    rgbImage = frame.cdata;
    bri = 118;
    brj = 100;
    % width= 65, and height= 90 for all; bri and brj are different, as below:
    % Daria(bri=122, brj=89); Denis(120,100); eli(118,107);  ido(117,102); ira(124,120); lena(126,101); lyova(120,100); moshe(,);shahar(118,100) 
    rgbSection = rgbImage(bri-90+1:bri, brj-65+1:brj, :);%88
    
    % Save the frame into a movie
    m = im2frame(rgbSection);    
    mov = addframe(mov, m);
    imshow(rgbSection);
    if f == startingFrame
        pause();
    else
        % pause(0.2);
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
    