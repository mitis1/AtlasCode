numPx = 512;
x = linspace(-1, 1, numPx);
[xx,yy] = meshgrid( x, x );

rr = sqrt( xx.^2 + yy.^2 );
pp = atan2(yy, xx);

L = 65* rr .* (rr <= 1);
A = 60* rr.* cos(pp).* (rr <= 1);
B = 60* rr.* sin(pp).* (rr <= 1);

L( rr> 1 ) =100;

LAB = cat(3, L, A, B);

RGB = lab2rgb(LAB);

RGB( RGB> 1) = 1;


figure
imshow(RGB)

%% to export the figure

figure;
imshow(RGB);
ax(1) = gca;
data_dir = ['/Users/nishagr/Documents/projects/Project_OrderedIC-master/' ...
                '2D_Fermion_Model/data'];

 exp_file_name = 'LDF_colorwheel';
 fullname = fullfile(data_dir, [exp_file_name,'.png']);
 exportgraphics(ax(1),fullname,'BackgroundColor','none','ContentType','vector');

 %% to write as tiff

 figure;
 imagesc(RGB)
 fullname = fullfile(data_dir, [exp_file_name,'.tif']);
 imwrite(im_temp, fullname_3);
