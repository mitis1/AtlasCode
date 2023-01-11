% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)


N = 812;
arr_sz = 50;
N_padded = 4096;
sg = 2;


x = -N/2:N/2-1;
[xx,yy] = meshgrid(x,x);
sg = 2;
w = 1;
h = 4;
r = 2;
obj_funct = @() soft_rectangle(xx, yy, w, h, sg);
obj_funct2 = @() soft_circle(xx, yy, r, sg);
a = 4.5;
r = 50;

t = -250:.1:250;
px = r*cosd(a*t);
py = r*sind(a*t);
z = a*t;
x_rot = rotx(82);

val = x_rot * [px;py;z];

px = val(1,:);
py = val(2,:);
z = val(3,:);

figure(1)
scatter(z, px, 'filled');



%%
obj = zeros(size(xx));
for i = 1:size(px,2)
    obj = obj + imtranslate(obj_funct2(), [z(i), py(i)], 'bilinear');
end

figure
imagesc(obj)




return
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
obj = padarray(obj, [(N_padded-N)/2, (N_padded-N)/2], 'both');
% obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift(fft2(ifftshift(obj)));

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
hold off;
