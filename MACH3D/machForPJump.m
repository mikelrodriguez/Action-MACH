close all
clear all;
clc;
action = 'pjump';

numVolumes = 6;
volumes = cell(1, numVolumes);

for v = 1 : numVolumes
    inFile = sprintf('D:\\Mikel\\mFiles\\Image Processing\\MACH3D\\%s_%0.3d.avi', action, v);
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
mach_file = sprintf('%s_mach.mat', action);
save (mach_file, 'mach3d')
return


% Save 3D MACH as a short movie clip

outFile = 'pjump_mach.avi';
mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', ifp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"
figure(1);
for f = 1 : ifp.NumFrames 
    rgbMACH = cat(3, mach3d(:,:,f), mach3d(:,:,f), mach3d(:,:,f));
    m = im2frame(rgbMACH);
    mov = addframe(mov, m);
    imshow(rgbMACH);
    pause(0.040);
end
mov = close(mov);


% Test 3-D MACH filter
% =======================

for testClip = 7 : 9
    switch(testClip)
        case 7
            inFileTest = sprintf('D:\\Mikel\\Databases\\Video Clips\\AVI\\Actions (M. Irani)\\Actions\\%s\\lyova_%s.avi', action, action);
        case 8
            inFileTest = sprintf('D:\\Mikel\\Databases\\Video Clips\\AVI\\Actions (M. Irani)\\Actions\\%s\\moshe_%s.avi', action, action);
        case 9
            inFileTest = sprintf('D:\\Mikel\\Databases\\Video Clips\\AVI\\Actions (M. Irani)\\Actions\\%s\\shahar_%s.avi', action, action);
    end

            
    iftp = aviinfo(inFileTest);
    volume = zeros(iftp.Height, iftp.Width, iftp.NumFrames, 'uint8');
    figure(2);
    for f = 1 : iftp.NumFrames
        frame = aviread(inFileTest, f);
        rgbImg = frame.cdata;
        grayImg = rgb2gray(rgbImg);
        edgeImg = sobel(grayImg);
        volume(:,:,f) = grayImg;
        % imshow(volume(:,:,f));
        % pause(0.040);
    end
    tic
    c = fftnormxcorr3(volume, mach3d);
    disp('');
    disp(sprintf('Test Clip: %d', testClip));
    disp('============')
    [cmax, i, j, k] = max3(c)
    toc

    lineWidth = 4;
    color = [255 255 0];

    % figure(3)
    switch(testClip)
        case 7
            outFile = sprintf('lyova_%s_result_gray.avi', action);
        case 8
            outFile = sprintf('moshe_%s_result_gray.avi', action);
        case 9
            outFile = sprintf('shahar_%s_result_gray.avi', action);
    end

    mov = avifile(outFile, 'COMPRESSION', 'None', 'FPS', iftp.FramesPerSecond, 'QUALITY', 100);  % "Indeo5" is better and offer more compression than "Cinepak"
    % for f = 1 : iftp.NumFrames
    %     frame = aviread(inFileTest, f);
    %     rgbImg = frame.cdata;
    %     if f >= k && f <= ifp.NumFrames
    %         rgbImg = putColorRectangle(rgbImg, i, j, i+ifp.Height-1, j+ifp.Width-1, lineWidth, color);
    %     else
    %         % Do nothing
    %     end
    %     imshow(rgbImg);
    %     m = im2frame(rgbImg);
    %     mov = addframe(mov, m);
    %     pause(1/iftp.FramesPerSecond)
    % end
    % mov = close(mov)

%     c2 = c;
%     % c2(c2 < 0.75) = 0;
%     figure(3);
%     for f = 1 : iftp.NumFrames - ifp.NumFrames + 1
%         % imagesc(c2(:,:,f));
%         c3 = uint8(scale(c2(:,:,f), min2(c2(:,:,f)), max2(c2(:,:,f)), 0, 255));
%         c3 = padarray(c3, [floor(ifp.Height/2), floor(ifp.Width/2)], 'both');
%         c3(c3 < 255*cmax) = 0;
%         frame = aviread(inFileTest, f);
%         rgbImg = frame.cdata;
%         c4 = cat(3, c3, c3, c3);
%         % rgbImg(1:iftp.Height-ifp.Height+1, 1:iftp.Width-ifp.Width+1);
%         result = [c4; rgbImg];
%         imshow(result);
%         pause(0.040);
%     end

%     figure(4)
%     for f = 1 : iftp.NumFrames - ifp.NumFrames + 1
%         [cmax2, i2, j2] = max2(c(:,:,f));
%         frame = aviread(inFileTest, f);
%         rgbImg = frame.cdata;
%         rgbImg = putColorRectangle(rgbImg, i2, j2, i2+ifp.Height-1, j2+ifp.Width-1, lineWidth, color);
%         imshow(rgbImg);
%         % m = im2frame(rgbImg);
%         % mov = addframe(mov, m);
%         pause(1/iftp.FramesPerSecond)
%         pause(0.040);
%     end
%     % mov = close(mov)

    figure(5)
    f = 1;
    while f <= iftp.NumFrames - ifp.NumFrames + 1
        [cmax2, i2, j2] = max2(c(:,:,f));
        if cmax2 > 0.725
           for f2 = f : f + ifp.NumFrames - 1
               frame = aviread(inFileTest, f2);
               rgbImg = frame.cdata;
               rgbImg = putColorRectangle(rgbImg, i2, j2, i2+ifp.Height-1, j2+ifp.Width-1, lineWidth, color);
               imshow(rgbImg);
               m = im2frame(rgbImg);
               mov = addframe(mov, m);
               pause(1/iftp.FramesPerSecond)
           end
           f = f + ifp.NumFrames;
        else
           frame = aviread(inFileTest, f);
           rgbImg = frame.cdata;
           imshow(rgbImg);
           m = im2frame(rgbImg);
           mov = addframe(mov, m);
           pause(1/iftp.FramesPerSecond)
           f = f + 1;
        end
    end
    mov = close(mov)
end


