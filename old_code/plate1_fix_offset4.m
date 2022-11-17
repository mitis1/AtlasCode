% using erf function and even size
clear; clc; close all;
% which image
row = 1;
col = 1;

% apeture parameters
r = [60, 60];
% 20, 40, 60
spacing = 400;
% 90, 400
N = 812; %number of pixels
l = 160;
w = 80;
noise_mean = 0;
noise_variance = 0.005;

% total_spacing = spacing/2 + r(1);
total_spacing = spacing/2;
if(spacing == 0)
    px = [N/2];
    py = [N/2];
else
    px = [N/2 - total_spacing, N/2 + total_spacing + 1];
    py = [N/2, N/2];
end

%Image Parameters
N_padded = 4096;
contrast_min = 98.5;
contrast_max = 99.93;
% contrast_min_log = 0;
% contrast_max_log = 99.97;
contrast_min_phase = 35;
contrast_max_phase = 80;
padding = (N_padded - N) / 2;
% contrast_combined = 30;
% contrast_combined = 100;

zoom_factor = 16;
crop_start = N_padded/2 - (N_padded/zoom_factor);
crop_end = N_padded/2 + (N_padded/zoom_factor);
filename_real = "plate1_real_" + string(row) + "_" + string(col) + ".tif";
filename_amp = "plate1_amplog_" + string(row) + "_" + string(col) + ".tif";
filename_amp2 = "plate1_amp_" + string(row) + "_" + string(col) + ".tif";
filename_phase = "plate1_phase_" + string(row) + "_" + string(col) + ".tif";

% make plate
[xx, yy] = meshgrid(1:N);

% printing circles
obj = zeros(N);
for i = 1:length(px)
    rr = sqrt((xx - px(i)).^2 + (yy-py(i)).^2);
    rr_erf1 = rr + erf(rr);
    rr_erf2 = rr - erf(rr);
    obj(rr <= r(i)) = 1;
    obj(rr_erf1 <= r(i)) = 1;
    obj(rr_erf2 <= r(i)) = 1;
end

% obj = shiftx(obj, 5);
% obj = shifty(obj, 0);
% printing rectangles
% obj = zeros(N);
% for i = 1:length(px)
%     x1 = xx - px(i);
%     y1 = yy - py(i);
%     obj(x1 <= w/2 & y1 <= l/2 & y1 >= -l/2 & x1 >= -w/2) = 1;
% end


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
set(gca, 'YDir', 'reverse');
hold off;

% take fft
obj = padarray(obj, [padding, padding], 'both');
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift( fft2(obj) );

%% amplitude
obj_amp = sqrt(((obj_fft).*conj(obj_fft)));
obj_amp = obj_amp - min(obj_amp(:));
obj_amp = obj_amp/max(obj_amp(:));
obj_amp(obj_amp == max(obj_amp(:))) = 0;
obj_amp = obj_amp/max(obj_amp(:));
obj_amp(obj_amp<=0.01) = 0;
obj_amp = rescale(obj_amp);
val_range = prctile(obj_amp, [contrast_min contrast_max], 'all');
obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);

amp = figure;
hold on;
imagesc(obj_amp);
colormap(amp_colormap(200, 0, 200));
colorbar;
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_amp2);
% imwrite(obj_fft2, filename_amp2, 'tif');
hold off;

%% phase
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
colormap("gray");
colorbar;
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_phase);
hold off;

%% combined
%separate amplitude and phase
pha = obj_phase;
amp = obj_amp;

%diffraction pattern
diff = amp.^2;

% [rcenter,ccenter] = find(diff == max(diff(:)));
% zb = 30;
% diff(rr2<zb^2) = 0;
% amp(rr2<zb^2) = 0;
% diff(rcenter-zb:rcenter+zb,ccenter-zb:ccenter+zb) = 0;
% amp(rcenter-zb:rcenter+zb,ccenter-zb:ccenter+zb) = 0;
% 
% figure
% imagesc((diff))
% colormap('gray')
% axis equal


%labspace
L = amp;
L = L*90;
a = L .* cos(pha);
b = L .* sin(pha); 


labim(:,:,1) = L;
labim(:,:,2) = a;
labim(:,:,3) = b;
rgbim = lab2rgb(labim);

rgb_blured = zeros(size(rgbim));



maxrgb = max(rgbim(:));
for i = 1:3
    rgb_blured(:,:,i) = imgaussfilt(rgbim(:,:,i),2);
end
rgb_blured = rgb_blured/max(rgb_blured(:))*maxrgb;
% rgb_blured = rgb_blured(crop_start:crop_end, crop_start:crop_end, :);

figure
imshow(rgb_blured);


% set contrast and crop - log
% obj_fft1 = log((obj_fft).*conj(obj_fft));
% obj_fft1 = rescale(obj_fft1);
% val_range = prctile(obj_fft1, [contrast_min contrast_max], 'all');
% obj_fft1 = imadjust(obj_fft1, [val_range(1) val_range(2)], [0 1]);
% obj_fft1 = obj_fft1(crop_start:crop_end, crop_start:crop_end);
% 
% log = figure;
% hold on;
% imagesc(obj_fft1);
% colormap("gray")
% axis square;
% axis tight;
% % axis off;
% imwrite(obj_fft1, filename_amp, 'tif');
% hold off;
