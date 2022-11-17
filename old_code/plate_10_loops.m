close all
clear; clc;

r = .1;
spacing = 0.2;
rows = 2;
cols = 3;

noise_variance = 0.01;
noise_mean = 0;
offset = 0;

% grid size
x_step = 0.001; %nm
y_step = 0.001; %nm
x_low = -1.024; %nm
x_upper = 1.024; %nm
y_low = -1.024; %nm
y_upper = 1.024; %nm
x = x_low:x_step:x_upper; %nm
y = y_low:y_step:y_upper; %nm


[xx, yy] = meshgrid(x, y);
rr1 = sqrt(xx.^2 + yy.^2);

%% circle matrix
num_pixels_x = ceil(r / x_step) + 1;
num_pixels_y = ceil(r / y_step) + 1;

% constants for filling in circle matrix
start_y = -(num_pixels_y-1) * y_step;
start_x = -(num_pixels_x-1) * x_step;
circle = ones(num_pixels_y*2-1, num_pixels_x*2-1);
circle = circle * offset;

% fill in circle matrix
x_idx = 1;
for x = start_x:x_step:abs(start_x)
    y_idx = 1;
    for y = start_y:y_step:abs(start_y)
        rr = sqrt(x ^ 2 + y ^ 2);
        if(rr <= r)
            circle(y_idx, x_idx) = 1;
        end
        y_idx = y_idx + 1;
    end
    x_idx = x_idx + 1;
end

%% calculating starting for circles
center_x = (size(rr1, 1) + 1)/2;
center_y = (size(rr1, 1) + 1)/2;

px_spacing = floor(spacing / x_step);
if(px_spacing == 0 && spacing ~= 0)
    px_spacing = 1;
end
px_radius = floor(r / x_step);

if(rows == 1 && cols == 1)
    y_offset = 0;
    x_offset = 0;
elseif (rows == 1)
    x_offset = px_radius * 2 + 1; % offset for first and last circle
    x_offset = x_offset + (((cols-1)/2)-1) * (2*px_radius + 1); % offset radius
    x_offset = x_offset + floor(cols/2) * (px_spacing);
    y_offset = 0;
elseif(cols == 1)
    x_offset = 0;
    y_offset = floor(((rows-1)/2))*px_spacing; % offset spacing
    y_offset = y_offset + floor(((rows-1)/2))*(px_radius*2 + 1); % offset middle
    y_offset = y_offset + px_radius + 1; % offset last atom
    y_offset = y_offset + ceil(px_spacing/2) - 1; % offset middle spacing
else
    x_offset = px_radius * 2 + 1; % offset for first and last circle
    x_offset = x_offset + (((cols-1)/2)-1) * (2*px_radius + 1); % offset radius
    x_offset = x_offset + floor(cols/2) * (px_spacing);
    
    y_offset = floor(((rows-1)/2))*px_spacing; % offset spacing
    y_offset = y_offset + floor(((rows-1)/2))*(px_radius*2 + 1); % offset middle
    y_offset = y_offset + px_radius + 1; % offset last atom
    y_offset = y_offset + ceil(px_spacing/2) - 1; % offset middle spacing
end
x_idx = center_x - x_offset;
y_idx = center_y - y_offset;

%% printing circles
circle_unit = 2*px_radius + 1 + px_spacing;
final = ones(size(rr1));
final = final * offset;
for x_circles = 1:cols
    for y_circles = 1:rows
        final(y_idx-px_radius:y_idx+px_radius, x_idx-px_radius:x_idx+px_radius) = circle(:,:);
        y_idx = y_idx + circle_unit;
    end
    x_idx = x_idx + circle_unit;
    y_idx = center_y - y_offset;
end

%% Plots
% make mask
mask_radius = (x_upper - x_low) / 2;
mask = rr1;
mask(rr1 <= mask_radius) = 1;
mask(rr1 > mask_radius) = 0;

final = final .* mask;
final = padarray(final, [512, 512], 'both');
final = imnoise(final, 'gaussian', noise_mean, noise_variance);
fft_final = fftshift(fft2(ifftshift(final)));

final_im = imag(fft_final);
final_real = real(fft_final);
final_phase = atan(final_im ./ final_real);

final_amp = (log(abs(fft_final)));

figure(1)
hold on;
set(gca, 'YDir', 'reverse');
imagesc(final);
% title('Real Space Image');
xlabel('x nm');
ylabel('y nm');
axis square;
axis tight;
% axis off;
% colorbar
colormap("gray")
hold off;

figure(2)
hold on;
set(gca, 'YDir', 'reverse');
% set(gca, 'YScale', 'log');
% set(gca, 'XScale', 'log');
imagesc(final_amp);
% title('Amplitude');
xlabel('kx');
ylabel('ky');
axis square;
axis tight;
colormap("gray")
hold off;