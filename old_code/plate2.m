clear; clc; close all;
% which image
row = 4;
col = 2;

% apeture parameters
r_circle = 20;
r_octagon = 80;
remove_pts = [4, 6];
N = 812; %number of pixels
noise_mean = 0;
noise_variance = 0.005;
px = [475 406 337 337 406 475];
py = [446 486 446 366 326 366];

%Image Parameters
N_padded = 4096;
contrast_min = 98.5;
contrast_max = 99.97;
% contrast_min_log = 0;
% contrast_max_log = 99.97;
contrast_min_phase = 30;
contrast_max_phase = 100;
padding = (N_padded - N) / 2;

zoom_factor = 16;
crop_start = N_padded/2 - (N_padded/zoom_factor);
crop_end = N_padded/2 + (N_padded/zoom_factor);
filename_real = "plate2_real_" + string(row) + "_" + string(col) + ".tif";
filename_amp = "plate2_amplog_" + string(row) + "_" + string(col) + ".tif";
filename_amp2 = "plate2_amp_" + string(row) + "_" + string(col) + ".tif";
filename_phase = "plate2_phase_" + string(row) + "_" + string(col) + ".tif";

% make plate
[xx, yy] = meshgrid(1:N);

% printing circles
obj = zeros(N);
count = 1;
for i = 1:length(px)
    if(count <= length(remove_pts) && i == remove_pts(count))
        count = count + 1;
        continue
    end
    rr = sqrt((xx - px(i)).^2 + (yy-py(i)).^2);
    obj(rr <= r_circle) = 1;
end

%Display real
disp_obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
disp_obj = rescale(disp_obj);
img = figure;
hold on;
colormap(flipud(colormap(gray)));
imagesc(disp_obj);
axis square;
axis tight;
axis off;
fig = gcf;
exportgraphics(fig, filename_real);
% set(gca, 'YDir', 'reverse');
hold off;

% take fft
obj = padarray(obj, [padding, padding], 'both');
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift( fft2(obj) );

% set contrast and crop - no log
obj_fft2 = ((obj_fft).*conj(obj_fft));
obj_fft2 = rescale(obj_fft2);
val_range = prctile(obj_fft2, [contrast_min contrast_max], 'all');
obj_fft2 = imadjust(obj_fft2, [val_range(1) val_range(2)], [0 1]);
obj_fft2 = obj_fft2(crop_start:crop_end, crop_start:crop_end);

no_log = figure;
hold on;
imagesc(obj_fft2);
colormap("gray")
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_amp2);
% imwrite(obj_fft2, filename_amp2, 'tif');
hold off;

obj_fft_im = imag(obj_fft);
obj_fft_real = real(obj_fft);
obj_phase = atan(obj_fft_im ./ obj_fft_real);
obj_phase = rescale(obj_phase);
val_range = prctile(obj_phase, [contrast_min_phase contrast_max_phase], 'all');
obj_phase = imadjust(obj_phase, [val_range(1) val_range(2)], [0 1]);
obj_phase = obj_phase(crop_start:crop_end, crop_start:crop_end);

phase = figure;
hold on;
imagesc(obj_phase);
colormap("gray")
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_phase);
hold off;