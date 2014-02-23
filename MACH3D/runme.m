%%%%%%%
%%% Main training/testing file
close all
clear all;
clc;

IraniDatasetPath = 'C:\MACH3D\MACH3D\actions\';
trainAction = 'bend';
threshold = 0.73; % bend: 0.725; pjump: 0.76; runleft: 0.73; jack: 0.77; wave1: 0.78
actions = {'bend', 'jack', 'jump', 'pjump', 'run', 'runleft', 'runright', 'side', 'skip', 'walk', 'wave1', 'wave2'};   %  'runleft', 'runright'
actors = {'daria', 'denis', 'eli', 'ido', 'ira', 'lena', 'lyova', 'moshe', 'shahar'};
trainActorID = [1 2 3 4 6 9]; % [1 2 3 4 6 9];   % [1 2 3 4 6 9];    % i.e. Training will be done on: daria, denis, eli, ido, lena, shahar 
testActorID = [5]; % [1, 7, 8];    %s[5 7 8]               % i.e. Testing of the trained 3D MACH filter will be done on all the actions done by: ira, lyova, and moshe

% programRootPath =  'D:\Mikel\mFiles\Image Processing\MACH3D\';

numActions = length(actions);
numTestActors = length(testActorID);
numTrainActors = length(trainActorID);
volumes = cell(1, numTrainActors);

for v = 1 : numTrainActors
    inFile = sprintf('%s_%0.3d.avi', trainAction, trainActorID(v));
    % inFile = [programRootPath, inFile];
    ifp = aviinfo(inFile);
    volume = zeros(ifp.Height, ifp.Width, ifp.NumFrames, 'uint8');
    for f = 1 : ifp.NumFrames
        frame = aviread(inFile, f);
        rgbImg = frame.cdata;
        grayImg = rgb2gray(rgbImg);
        edgeImg = sobel(grayImg);
        volume(:,:,f) = edgeImg;
    end
    volumes{v} = volume;
end
mach3d = train_otmach3(volumes);
mach_file = sprintf('%s_mach.mat', trainAction);
save (mach_file, 'mach3d')


% Save 3D MACH as a short movie clip

machMovieFile = sprintf('%s_mach.avi', trainAction);
mov = avifile(machMovieFile, 'COMPRESSION', 'None', 'FPS', ifp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"
figure(1);
for f = 1 : ifp.NumFrames 
    rgbMACH = cat(3, mach3d(:,:,f), mach3d(:,:,f), mach3d(:,:,f));
    m = im2frame(rgbMACH);
    mov = addframe(mov, m);
    imshow(rgbMACH);
    pause(0.040);
end
disp('3D MACH Filter as a Movie');
disp('=========================');
mov = close(mov)


% Test 3-D MACH filter
% =======================
for a = 1 : numActions
    for v = 1 : numTestActors

        inFileTest = [IraniDatasetPath, sprintf('%s\\%s_%s.avi', actions{a}, actors{testActorID(v)}, actions{a})];
       

        iftp = aviinfo(inFileTest);
        volume = zeros(iftp.Height, iftp.Width, iftp.NumFrames, 'uint8');
        figure(2);
        for f = 1 : iftp.NumFrames
            frame = aviread(inFileTest, f);
            rgbImg = frame.cdata;
            grayImg = rgb2gray(rgbImg);
            edgeImg = sobel(grayImg);
            volume(:,:,f) = edgeImg;
    
        end
        tic
        c = fftnormxcorr3(volume, mach3d);
        disp('');
        disp(sprintf('Test Clip: %s_%s.avi', actors{testActorID(v)}, actions{a}));
        disp('============================')
        [cmax, i, j, k] = max3(c)
        toc

        lineWidth = 4;
        color = [255 255 0];


        outFile = sprintf('Result_TrainedOn_%s_TestedOn_%s_%s.avi', trainAction, actions{a}, actors{testActorID(v)}); 

        mov = avifile(outFile, 'COMPRESSION', 'Indeo5', 'FPS', iftp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"

        figure(4)
        for f = 1 : iftp.NumFrames - ifp.NumFrames + 1
            [cmax2, i2, j2] = max2(c(:,:,f));
            frame = aviread(inFileTest, f);
            rgbImg = frame.cdata;
            if cmax2 > threshold
                rgbImg = putColorRectangle(rgbImg, i2, j2, i2+ifp.Height-1, j2+ifp.Width-1, lineWidth, color);
                rgbImg = putColorCrossHair(rgbImg, 'rgb', round(i2+ifp.Height/2), round(j2+ifp.Width/2), 25, 25, 3, color);
            end
            imshow(rgbImg);
             m = im2frame(rgbImg);
             mov = addframe(mov, m);
            pause(1/iftp.FramesPerSecond)
            pause(0.040);
        end
        mov = close(mov)


    end
end


