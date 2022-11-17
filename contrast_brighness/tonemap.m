
cmap = @(N) cmap5(N);
% figure(1)
% for i = 1:3
%     % fname = "ronchi"+(i+2)+".png";
%     fname = "matlab_gen_"+(i+10)+".png";
%     im = double(imread(fname));
%     im = imgaussfilt(im, 0.5);
%     im = -im(:,:,1);
%     
%     
%     subplot(1,3,i)
%     imagesc( (im) )
%     axis equal off
%     colormap( magma(8) )
% 
% end

figure(2)
fname = "plate10_amplog_2_3.tif";
im = double(imread(fname));
im = imgaussfilt(im,0.4);
im = -im(:,:,1);

imagesc(im)
axis equal off
% colormap(plasma(16))
colormap(flipud(colormap("gray")));