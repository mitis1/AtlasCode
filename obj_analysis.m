clear; clc; close all;
% parameters
% object parameters
N = 812;
N_padded = 4096;
sg = 2;

plate = 1;

figure
for row = 1:4
    for col = 1:3
        subplot(4,3, col+(row-1)*3)
        plate_func = str2func( sprintf("@(row, col, N, sg) plate%02d_obj(row, col, N, sg)",plate));

        obj = plate_func( row, col, N, sg );

        imagesc(obj)
        axis image off
        colormap gray
    end
end
sgtitle( sprintf("Plate %02d", plate))


return
%%
plate = 4;
row = 4;
col = 1;

r_outer = 140;
r_hex = 80;
r_circle = 20;
rm_hex1 = [2, 3, 5, 6];
rm_pts1 = [1, 3, 4, 6];
rm_hex2 = [1, 3, 4, 5];
rm_pts2 = [1, 2, 5, 6];
sg = 5;
obj1 = plate4_obj(N, r_outer,r_hex, r_circle, rm_hex1, rm_pts1, sg);
obj2 = plate4_obj(N, r_outer,r_hex, r_circle, rm_hex2, rm_pts2, sg);
obj = obj1 + obj2;
obj(obj > 1) = obj(obj>1)/2;

% image parameters
noise_mean = 0;
noise_variance = 0.005;

contrast_min_amp = 98.9;
% was 99.96
contrast_max_amp = 99.96;
contrast_min2 = 98;
contrast_max2 = 99.98;

contrast_min_phase = 50;
contrast_max_phase = 99;

L_combined = 100;

zoom_factor = 8;
crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));

filename_real = "plate" + string(plate) + "_real_" + string(row) + "_" + string(col) + ".tif";
filename_amp2 = "plate" + string(plate) + "_amp_" + string(row) + "_" + string(col) + ".tif";
filename_phase = "plate" + string(plate) + "_phase_" + string(row) + "_" + string(col) + ".tif";
filename_combined = "plate" + string(plate) + "_comb_" + string(row) + "_" + string(col) + ".tif";


% object analysis
x = (-N/2):(N/2+1);
% imagesc(x, x, obj);
axis equal xy off
% return
% obj = rescale(obj);
disp_obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
% disp_obj = obj;

obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift(fft2(ifftshift(obj)));

obj_pha = angle(obj_fft);
obj_amp = abs(obj_fft);

% real image display
x_full = (-N_padded/2):(N_padded/2+1);
img = figure;
hold on;
colormap(flipud(colormap(gray)));
% imagesc(x_full, x_full, disp_obj);
imagesc(disp_obj);
datacursormode;
axis square;
axis tight;
axis off;
fig = gcf;
exportgraphics(fig, filename_real);
hold off;

% amplitude display
% amplitude contrast and crop
obj_amp = rescale(obj_amp);
val_range = prctile(obj_amp, [contrast_min_amp contrast_max_amp], 'all');
obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);

amp = figure;
hold on;
imagesc(obj_amp);
colormap(amp_colormap(254, 0, 254))
% colorbar
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_amp2);
hold off;

% phase display
% phase contrast and crop
obj_phase = rescale(obj_pha);
val_range = prctile(obj_phase, [contrast_min_phase contrast_max_phase], 'all');
obj_phase = imadjust(obj_phase, [val_range(1) val_range(2)], [0 1]);
obj_phase = obj_phase(crop_start:crop_end, crop_start:crop_end);

phase = figure;
hold on;
imagesc(obj_phase);
colormap(amp_colormap(200, 0, 200))
% colorbar
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_phase);
hold off;

%% combined display
% combined calculation
% contrast_min2 = 98;
% contrast_max2 = 99.9;
% L_combined = .00001;
% contrast_max2 = 99.98;
obj_amp = abs(obj_fft);
obj_amp = rescale(obj_amp);
val_range = prctile(obj_amp, [contrast_min2 contrast_max2], 'all');
obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);

obj_pha = angle(obj_fft) + pi/2;
obj_pha = obj_pha(crop_start:crop_end, crop_start:crop_end);

L = L_combined * (obj_amp);
a = L.*cos(obj_pha);
b = L.*sin(obj_pha);
pha_rgb = lab2rgb( cat(3, L, a, b));
pha_rgb( pha_rgb>1 ) = 1;
pha_rgb( pha_rgb<0 ) = 0;

% pha_rgb = pha_rgb(crop_start:crop_end, crop_start:crop_end, :);

rgb_blured = zeros(size(pha_rgb));

maxrgb = max(pha_rgb(:));
for i = 1:3
    rgb_blured(:,:,i) = imgaussfilt(pha_rgb(:,:,i),2);
end
rgb_blured = rgb_blured/max(rgb_blured(:))*maxrgb;

combined = figure;
hold on;
imagesc(pha_rgb);
axis square;
axis tight;
axis off;
exportgraphics(gcf, filename_combined);
hold off;




%%
% r_circle = 40;
% % 20, 40, 60
% spacing = 400;
% % 90, 400
% y_range = 160;
% x_range = 80;
% plate1_obj(N, false, r_circle, spacing, x_range, y_range, 5)

% r = 20;
% r_hex = 80;
% rm_pts = [];
% sg = 5;
% plate2_obj(N, r_hex, r, rm_pts, sg)

% r_circle = 20;
% r_oct1 = 80;
% r_oct2 = 140;
% obj = plate3_obj(N, r_circle, r_oct1, r_oct2, 5, []);

% r_outer = 140;
% r_hex = 80;
% r_circle = 20;
% % rm_hex = [];
% % rm_pts = [];
% % sg = 5;
% % obj = plate4_obj(N, r_outer,r_hex, r_circle, rm_hex, rm_pts, sg);
% % rm_hex1 = [2, 3, 5, 6];
% % rm_pts1 = [1, 3, 4, 6];
% % rm_hex2 = [1, 3, 4, 5];
% % rm_pts2 = [1, 2, 5, 6];
% % sg = 5;
% % obj1 = plate4_obj(N, r_outer,r_hex, r_circle, rm_hex1, rm_pts1, sg);
% % obj2 = plate4_obj(N, r_outer,r_hex, r_circle, rm_hex2, rm_pts2, sg);
% % obj = obj1 + obj2;
% % obj(obj > 1) = obj(obj>1)/2;

% r_big = 0;
% r_hex = 95;
% r_circle = 20;
% obj = plate5_obj(N, row, col, r_circle, r_hex, r_big, 5);


