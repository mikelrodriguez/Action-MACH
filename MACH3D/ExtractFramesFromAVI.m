aviFile = 'D:\Mikel\mFiles\Image Processing\MACH3D\Result_TrainedOn_bend_TestedOn_bend_ira.avi';
aviInfo = aviinfo(aviFile)
for f = 1 : 100
     if f == 1 || f == 6 || f == 7 || f == 8 || f == 12 || f == 14 || f == 18 || f == 19 || f == 20 || f == 24 || f == 36 || f == 48 || f == 60 || f == 66 || f == 67 || f == 70 || f == 72
        m = aviread(aviFile, f);
        imwrite(m.cdata, sprintf('Result_TrainedOn_bend_TestedOn_bend_ira_%0.2d.jpg', f));
     end
 end