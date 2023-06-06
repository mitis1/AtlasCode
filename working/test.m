N = 812;
N_padded = 4096;
close all;

[px,py] = hilbert(5);

ratio = N/(max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;

obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
line_width = 3;
sg = 5;
obj_funct = @(w, h) draw_rectangle(xx, yy, w, h, sg);

for i = 2:size(px,2)
    if(px(i) == px(i-1))
        py_temp = (py(i)+py(i-1))/2;
        h = abs(py(i) - py(i-1));
        obj = obj + imtranslate(obj_funct(line_width, h), [px(i), py_temp], 'bilinear');
    else
        px_temp = (px(i)+px(i-1))/2;
        w = abs(px(i) - px(i-1));
        obj = obj + imtranslate(obj_funct(w, line_width), [px_temp, py(i)], 'bilinear');
    end
end



%%
% Display object

% image parameters
noise_mean = 0;
noise_variance = 0.0005;
% noise_variance = 0.0001;

% Crop for FFT
zoom_factor = 8;
crop_start = (N_padded)/2 - ((N_padded)/(zoom_factor*2)) + 1;
crop_end = (N_padded)/2 + ((N_padded)/(zoom_factor*2));


% Contrast for FFT
contrast_min_amp = 97.9;
% was 99.96
contrast_max_amp = 100;
contrast_min2 = 99.7;
contrast_max2 = 99.98;
% contrast_max2 = 99.97;
contrast_min = 98;
contrast_max = 99.9;


% dispobj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
dispobj = obj;
dispobj = (rescale( -dispobj ) );
figure(4)
hold on;
imagesc(dispobj);
colormap('gray')
axis square
axis off
hold off;

% Fourier Transform object
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
obj1 = obj .* draw_circle(xx, yy, 400, 10);
obj1 = padarray(obj1, [(N_padded-N)/2, (N_padded-N)/2], 'both');
obj1 = imnoise(obj1, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift(fft2(ifftshift(obj1)));
obj_amp = abs(obj_fft);
obj_amp = rescale(obj_amp);
val_range = prctile(obj_amp, [contrast_min2 contrast_max2], 'all');
obj_amp = imadjust(obj_amp, [val_range(1) val_range(2)], [0 1]);
obj_amp = obj_amp(crop_start:crop_end, crop_start:crop_end);

obj_pha = angle(obj_fft) + pi/2;
obj_pha = obj_pha(crop_start:crop_end, crop_start:crop_end);

L = 100 * (obj_amp);
a = L.*cos(obj_pha);
b = L.*sin(obj_pha);
pha_rgb = lab2rgb( cat(3, L, a, b));
pha_rgb( pha_rgb>1 ) = 1;
pha_rgb( pha_rgb<0 ) = 0;

figure(5)
hold on;
imagesc( pha_rgb);
axis square
axis off
hold off

