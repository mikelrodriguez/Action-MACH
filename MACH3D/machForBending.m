close all
clear all;
clc;
numVolumes = 6;
volumes = cell(1, numVolumes);

figure(1);
for v = 1 : numVolumes
    inFile = sprintf('D:\\Mikel\\mFiles\\Image Processing\\MACH3D\\bend_%0.3d.avi', v);
    ifp = aviinfo(inFile);
    volume = zeros(ifp.Height, ifp.Width, ifp.NumFrames, 'uint8');
    for f = 1 : ifp.NumFrames
        frame = aviread(inFile, f);
        rgbImg = frame.cdata;
        grayImg = rgb2gray(rgbImg);
        edgeImg = sobel(grayImg);
        volume(:,:,f) = edgeImg;
        imshow(volume(:,:,f));
    end
    volumes{v} = volume;
end

mach3d = train_otmach3(volumes);
save bend_mach.mat mach3d
outFile = 'bend_mach.avi';
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', ifp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"
for f = 1 : ifp.NumFrames 
    % Save the MACH frame into a movie
    rgbMACH = cat(3, mach3d(:,:,f), mach3d(:,:,f), mach3d(:,:,f));
    m = im2frame(rgbMACH);
    mov = addframe(mov, m);
    imshow(rgbMACH);
    pause(0.040);
end
mov = close(mov);

% Test 3-D OT-MACH filter
inFileTest = 'D:\Mikel\Databases\Video Clips\AVI\Actions (M. Irani)\Actions\bend\lena_bend.avi';
iftp = aviinfo(inFileTest);
volume = zeros(iftp.Height, iftp.Width, iftp.NumFrames, 'uint8');
for f = 1 : iftp.NumFrames
    frame = aviread(inFileTest, f);
    rgbImg = frame.cdata;
    grayImg = rgb2gray(rgbImg);
    edgeImg = sobel(grayImg);
    volume(:,:,f) = edgeImg;
    imshow(volume(:,:,f));
    pause(0.040);
end
tic
c = fftnormxcorr3(volume, mach3d);
[cmax, i, j, k] = max3(c)
toc

lineWidth = 4;
color = [255 255 0];
figure(2);
outFile = sprintf('lena_bend_result.avi');
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', iftp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"
for f = 1 : iftp.NumFrames
    frame = aviread(inFileTest, f);
    rgbImg = frame.cdata;
    if f >= k && f <= ifp.NumFrames
        rgbImg = putColorRectangle(rgbImg, i, j, i+ifp.Height-1, j+ifp.Width-1, lineWidth, color);
    else
        % Do nothing
    end
    imshow(rgbImg);
    m = im2frame(rgbImg);
    mov = addframe(mov, m);
    pause(1/iftp.FramesPerSecond)
end
mov = close(mov)

