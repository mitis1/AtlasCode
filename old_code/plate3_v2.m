clear; clc; close all;
% which image
row = 1;
col = 1;

% apeture parameters
r_circle = 20;
r_octagon1 = 80;
r_octagon2 = 140;
remove_pts = [];
N = 811; %number of pixels
noise_mean = 0;
noise_variance = 0.005;
px1 = [476 406 336 336 406 476];
py1 = [446 486 446 366 326 366];

px2 = [526 406 286 286 406 526];
py2 = [476 546 476 336 266 336];

% px1 = [475 406 337 337 406 475];
% py1 = [446 486 446 366 326 366];
% 
% px2 = [527 406 285 285 406 527];
% py2 = [476 546 476 336 266 336];

%Image Parameters
N_padded = 4095;
contrast_min = 98.9;
contrast_max = 99.97;
% contrast_min_log = 0;
% contrast_max_log = 99.97;
contrast_min_phase = 50;
contrast_max_phase = 99;
padding = (N_padded - N) / 2;

zoom_factor = 16;
crop_start = (N_padded+1)/2 - ((N_padded+1)/zoom_factor);
crop_end = (N_padded+1)/2 + ((N_padded+1)/zoom_factor);
filename_real = "plate3_real_" + string(row) + "_" + string(col) + ".tif";
% filename_amp = "plate3_amplog_" + string(row) + "_" + string(col) + ".tif";
filename_amp2 = "plate3_amp_" + string(row) + "_" + string(col) + ".tif";
filename_phase = "plate3_phase_" + string(row) + "_" + string(col) + ".tif";
filename_combined = "plate3_comb_" + string(row) + "_" + string(col) + ".tif";

% make plate
[xx, yy] = meshgrid(1:N);

% printing circles
obj = zeros(N);
count = 1;

for i = 1:length(px1)
    rr = sqrt((xx - px1(i)).^2 + (yy-py1(i)).^2);
    rr_erf1 = rr + erf(rr);
    rr_erf2 = rr - erf(rr);
    obj(rr <= r_circle) = 1;
    obj(rr_erf1 <= r_circle) = 1;
    obj(rr_erf2 <= r_circle) = 1;
end

for i = 1:length(px2)
    if(count <= length(remove_pts) && i == remove_pts(count))
        count = count + 1;
        continue
    end
    rr = sqrt((xx - px2(i)).^2 + (yy-py2(i)).^2);
    rr_erf1 = rr + erf(rr);
    rr_erf2 = rr - erf(rr);
    obj(rr <= r_circle) = 1;
    obj(rr_erf1 <= r_circle) = 1;
    obj(rr_erf2 <= r_circle) = 1;
end


%% Display real
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

%% Amplitude
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
colormap("bone")
colorbar
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_amp2);
% imwrite(obj_fft2, filename_amp2, 'tif');
hold off;

obj_phase = angle(obj_fft);
obj_phase = rescale(obj_phase);
val_range = prctile(obj_phase, [contrast_min_phase contrast_max_phase], 'all');
obj_phase = imadjust(obj_phase, [val_range(1) val_range(2)], [0 1]);
obj_phase = obj_phase(crop_start:crop_end, crop_start:crop_end);

phase = figure;
hold on;
imagesc(obj_phase);
colormap("bone")
colorbar
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_phase);
hold off;

%% combined
%separate amplitude and phase
obj_phase = angle(obj_fft);
obj_phase = obj_phase(crop_start:crop_end, crop_start:crop_end);
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
L = L*70;
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

combined = figure;
hold on;
imagesc(rgb_blured);
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_combined);
hold off;