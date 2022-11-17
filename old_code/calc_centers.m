clear; clc;
close all;
% calculating start of circles
spacing = 60;
rows = 6;
cols = 1;
r = 30;
N = 812;

x_offset = ((cols-1)/2)*(2*r + 1 + spacing);
y_offset = (rows/2)*(spacing + 2*r + 1) - (spacing/2);
% y_offset = 0;
x_idx = N/2 - x_offset;
y_idx = N/2 - y_offset;
circle_spacing = r*2 + 1 + spacing;

px = [];
py = [];
inc = 1;
for i = 1:rows
    for j = 1:cols
        px(inc) = x_idx;
        py(inc) = y_idx;
        x_idx = x_idx + circle_spacing;
        inc = inc + 1;
    end
    x_idx = N/2 - x_offset;
    y_idx = y_idx + circle_spacing;
    
end

%PLATE 10 - 1 Seven circles in a row vertically, evenly spaced

%Circle radii
r = [30, 30, 30, 30, 30, ...
    30, 30, 30, 30, 30, ...
    30, 30, 30, 30, 30, ...
    30, 30, 30, 30, 30, ...
    30, 30, 30, 30, 30, ...
    30, 30, 30, 30, 30];
spacing = [60, 60, 60, 60, 60, ...
          60, 60, 60, 60, 60, ...
          60, 60, 60, 60, 60, ...
          60, 60, 60, 60, 60, ...
          60, 60, 60, 60, 60, ...
          60, 60, 60, 60, 60];
noise_mean = 0;
noise_variance = 0.01;

%Image Parameters
N = 812; %number of pixels
N_padded = 4096;
padding = (N_padded - N) / 2;
contrast_min = 50;
contrast_max = 99.995;
contrast_min_log = 50;
contrast_max_log = 99.975;

zoom_factor = 16;
crop_start = N_padded/2 - (N_padded/zoom_factor);
crop_end = N_padded/2 + (N_padded/zoom_factor);
filename_real = "plate10_real_" + string(rows) + "_" + string(cols) + ".tif";
filename_amp = "plate10_amplog_" + string(rows) + "_" + string(cols) + ".tif";
filename_amp2 = "plate10_amp_" + string(rows) + "_" + string(cols) + ".tif";

%Make Object
[xx, yy] = meshgrid(1:N);

% printing circles
obj = zeros(N);
obj1 = zeros(N);
for i = 1:length(px)
    rr = sqrt((xx - px(i)).^2 + (yy-py(i)).^2);
    obj(rr <= r(i)) = 1;
end

disp_obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
disp_obj = rescale(disp_obj);
%Display Result
img = figure;
hold on;
colormap(flipud(colormap(gray)));
% cmp = colormap(invert_grey(100));
img1 = imagesc(disp_obj);
axis square;
axis tight;
axis off;
fig = gcf;
exportgraphics(fig, filename_real);
set(gca, 'YDir', 'reverse');
hold off;

obj = padarray(obj, [padding, padding], 'both');
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift( fft2(obj) );
obj_fft1 = log((obj_fft).*conj(obj_fft));
obj_fft1 = rescale(obj_fft1);
val_range = prctile(obj_fft1, [contrast_min contrast_max], 'all');
obj_fft1 = imadjust(obj_fft1, [val_range(1) val_range(2)], [0 1]);
% obj_fft1 = rescale(obj_fft1, 0, 255);
obj_fft1 = obj_fft1(crop_start:crop_end, crop_start:crop_end);

adj_contrast = figure;
hold on;
imagesc(obj_fft1);
colormap("gray")
axis square;
axis tight;
% axis off;
imwrite(obj_fft1, filename_amp, 'tif');
hold off;

obj_fft2 = ((obj_fft).*conj(obj_fft));
obj_fft2 = rescale(obj_fft2);
val_range = prctile(obj_fft2, [contrast_min_log contrast_max_log], 'all');
obj_fft2 = imadjust(obj_fft2, [val_range(1) val_range(2)], [0 1]);
% obj_fft2 = rescale(obj_fft2, 0, 255);
obj_fft2 = obj_fft2(crop_start:crop_end, crop_start:crop_end);

no_log = figure;
hold on;
imagesc(obj_fft2);
colormap("gray")
axis square;
axis tight;
% axis off;
imwrite(obj_fft2, filename_amp2, 'tif');
hold off;
% axis off;
% % axis off;
% hold off;