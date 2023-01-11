clear; clc; close all;
%% parameters
% object parameters
N = 812;
N_padded = 4096;

% plate 41
% N = 812;
% N_padded = 812;
sg = 2;

% image parameters
noise_mean = 0;
% original
% noise_variance = 0.005;
% changed
noise_variance = 0.0001;

% Crop for FFT
% original
% zoom_factor = 8;
% changed
zoom_factor = 4;

crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));

% Contrast for FFT
% contrast_min_amp = 98.9;
% % was 99.96
% contrast_max_amp = 99.96;
% actual
contrast_min2 = 98;
contrast_max2 = 99.98;
% test
% contrast_min2 = 99.4;
% contrast_max2 = 99.9;

% contrast_min_phase = 50;
% contrast_max_phase = 99;

plates = [23];
rows = 1:4;
cols = 1:3;

%% Preallocate folders
mkdir('Plates')

for plate = plates
    mkdir( fullfile('Plates', sprintf('plate%02d', plate)) )
end

%%
fig = [figure, figure];
for i = 1:12
    figure( fig(1) )
    ax1(i) = subplot(4,3,i);
    figure( fig(2) )
    ax2(i) = subplot(4,3,i);
end

for row = 1:4
for col = 1:3
    % Generate object
    plate_func = str2func( sprintf("@(row, col, N, sg) plate%02d_obj(row, col, N, sg)",plate));
    obj = plate_func( row, col, N, sg );
    
    % Display object
%     obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
    dispobj = (rescale( -obj ) );
    imagesc(ax1(col+(row-1)*3),  dispobj);
    colormap( ax1(col+(row-1)*3), 'gray')

    % Fourier Transform object
    obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
    obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
    obj_fft = fftshift(fft2(ifftshift(obj)));

% for plate 41
%     obj_fft = fftshift(fft2(ifftshift(obj)));
    
    obj_amp = abs(obj_fft);
    obj_amp = rescale(obj_amp);
    val_range = prctile(obj_amp, [contrast_min2 contrast_max2], 'all');
    if(val_range(1) ~= val_range(2) || plates(1) ~= 41)
        obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
    end
    obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);
    
    obj_pha = angle(obj_fft) + pi/2;
    obj_pha = obj_pha(crop_start:crop_end, crop_start:crop_end);

    L = 100 * (obj_amp);
    a = L.*cos(obj_pha);
    b = L.*sin(obj_pha);
    pha_rgb = lab2rgb( cat(3, L, a, b));
    pha_rgb( pha_rgb>1 ) = 1;
    pha_rgb( pha_rgb<0 ) = 0;


    im2 = imagesc(ax2(col+(row-1)*3),  pha_rgb);
    
    drawnow

    % Saving
    cur_path = fullfile('Plates', sprintf('plate%02d', plate)) ;
    fname_obj = sprintf("plate%02d_%d_%d_obj.png", plate, row, col);
    fname_fft = sprintf("plate%02d_%d_%d_fft.png", plate, row, col);

    imwrite( uint8(255*dispobj), fullfile(cur_path, fname_obj))
    imwrite( uint8(255*pha_rgb), fullfile(cur_path, fname_fft))

end
end
axis( ax1, 'equal', 'off')
axis( ax2, 'equal', 'off')


sgtitle( sprintf("Plate %02d", plate))

