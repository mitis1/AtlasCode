clear; clc; close all;
%% parameters
% object parameters
N = 812;
N_padded = 4096;

sg = 2;

% image parameters
noise_mean = 0;
% original
noise_variance = 0.005;
% test
% noise_variance = 0.001;

% Crop for FFT
zoom_factor = 8;

% Contrast for FFT
% original
contrast_min = 98;
contrast_max = 99.98;
%test
% contrast_min = 97;
% contrast_max = 99.98;

% plates = [1:21,23:25,33:46,48];
plates = [54];
rows = 1:4;
cols = 1:3;

%% Preallocate folders
mkdir('Plates2')

for plate = plates
    mkdir( fullfile('Plates2', sprintf('plate%02d', plate)) )

% setting different parameters
if(plate == 44 || plate == 48 || plate == 20 || plate == 21 || plate == 23 || plate == 52)
    zoom_factor = 6;
elseif(plate == 20 || plate == 25 || plate == 18 || plate == 11 || plate == 12 || plate == 55 || plate == 54)
    zoom_factor = 4;
elseif(plate == 19)
    zoom_factor = 2;
end

if(plate == 34 || plate == 11 || plate == 12 || plate == 23)
    noise_variance = 0.0001;
end

if(plate == 34)
    contrast_max = 99.96;
end
if(plate == 52)
%     N_padded = 812;
%     contrast_max = 99;
%     contrast_min = 95;
end
if(plate == 41)
    N_padded = 812;
end

fig = [figure(plate), figure(plate+max(plates))];
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
    dispobj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
    dispobj = (rescale( -dispobj ) );
    imagesc(ax1(col+(row-1)*3),  dispobj);
    colormap( ax1(col+(row-1)*3), 'gray')

    % Fourier Transform object
    if(plate ~= 41)
        xs = -N/2:N/2-1;
        [xx,yy] = meshgrid( xs,xs );
        obj = obj .* draw_circle(xx, yy, 400, 10);
        obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
        obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
        obj_fft = fftshift(fft2(ifftshift(obj)));
%     elseif(plate == 41)
    else
        obj_fft = fftshift(fft2(ifftshift(obj)));
%     else
%         obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
%         obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
%         obj_fft = fftshift(fft2(ifftshift(obj)));
    end
    
    obj_amp = abs(obj_fft);
    obj_amp = rescale(obj_amp);
    val_range = prctile(obj_amp, [contrast_min contrast_max], 'all');
    if(val_range(1) ~= val_range(2) || plates(1) ~= 41)
        obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
    end
    
    %cropping fourier transform
    crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
    crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));
    obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);
    
    obj_pha = angle(obj_fft) + pi/2;
    obj_pha = obj_pha(crop_start:crop_end, crop_start:crop_end);

%     L = 100 * (obj_amp);
% test
L = 100*(obj_amp);
    if(plate == 44)
        L = 80 * obj_amp;
    end

    a = L.*cos(obj_pha);
    b = L.*sin(obj_pha);
    pha_rgb = lab2rgb( cat(3, L, a, b));
    pha_rgb( pha_rgb>1 ) = 1;
    pha_rgb( pha_rgb<0 ) = 0;


    im2 = imagesc(ax2(col+(row-1)*3),  pha_rgb);
    
    drawnow

    % Saving
    cur_path = fullfile('Plates2', sprintf('plate%02d', plate)) ;
    fname_obj = sprintf("plate%02d_%d_%d_obj.png", plate, row, col);
    fname_fft = sprintf("plate%02d_%d_%d_fft.png", plate, row, col);

    imwrite( uint8(255*dispobj), fullfile(cur_path, fname_obj))
    imwrite( uint8(255*pha_rgb), fullfile(cur_path, fname_fft))

end
end
axis( ax1, 'equal', 'off')
axis( ax2, 'equal', 'off')


sgtitle( sprintf("Plate %02d", plate))
end

