%PLATE 10 - 1 Seven circles in a row vertically, evenly spaced
close all;
clear; clc;

%Circle radii
r = 30;
spacing = 60;
rows = 6;
cols = 1;
noise_mean = 0;
noise_variance = 0.01;

%Image Parameters
N = 812; %number of pixels

%Make Object
[xx, yy] = meshgrid(1:N);

%% calculating circle locations

% calculating start of circles
x_offset = floor(cols/2)*(2*r + 1 + spacing);
y_offset = floor(rows/2)*(spacing + 2*r + 1) - ceil(spacing/2);
if (cols == 1)
    x_offset = 0;
end
if(rows == 1)
    y_offset = 0;
end
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

%% printing circles

obj = zeros(N);
for i = 1:length(px)
    rr = sqrt((xx - px(i)).^2 + (yy-py(i)).^2);
    for j = 1:size(obj, 1)
        for k = 1:size(obj, 2)
            if(rr(j, k) <= r)
                obj(j, k) = 1;
            end
        end
    end
end

%FFT Object
%Display Result
img = figure;
hold on;
imagesc(obj);
set(gca, 'YDir', 'reverse');
% title('Real Space');
% xlabel('x');
% ylabel('y');
axis square;
axis tight;
% axis off;
colormap("gray");
colormap(flipud(colormap));
hold off;

obj = padarray(obj, [618, 618], 'both');
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
obj_fft = fftshift( fft2(obj) );
obj_fft = log(abs(obj_fft));

amp = figure;
hold on;
imagesc(obj_fft(824:1224, 824:1224));
set(gca, 'YDir', 'reverse');
% title('Amplitude');
% xlabel('kx');
% ylabel('ky');
axis square;
axis tight;
axis off;
colormap("gray")
hold off;

img = obj_fft(824:1224, 824:1224);
img_hist = figure;
hold on;
hist(img(:), 15);
hold off;
% normalize
% obj_fft_min = min(min(obj_fft));
% obj_fft_norm = obj_fft - obj_fft_min;
% obj_fft_norm = obj_fft_norm / max(max(obj_fft_norm));
% obj_fft_norm = obj_fft_norm * 225;
% 
% amp_nrom = figure;
% hold on;
% imagesc(obj_fft_norm(824:1224, 824:1224));
% set(gca, 'YDir', 'reverse');
% % title('Amplitude');
% % xlabel('kx');
% % ylabel('ky');
% axis square;
% axis tight;
% axis off;
% colormap("gray")
% hold off;

% black and white
% obj_fft_bw = imbinarize(obj_fft, 'adaptive', 'Sensitivity', 0.9);
% amp_bw = figure;
% hold on;
% imagesc(obj_fft_bw(824:1224, 824:1224));
% set(gca, 'YDir', 'reverse');
% % title('Amplitude');
% % xlabel('kx');
% % ylabel('ky');
% axis square;
% axis tight;
% axis off;
% colormap("gray")
% hold off;

% gaussian smoothing
% obj_fft_gauss = smoothdata(obj_fft, 'g');
% amp_bw = figure;
% hold on;
% imagesc(obj_fft_gauss(824:1224, 824:1224));
% set(gca, 'YDir', 'reverse');
% % title('Amplitude');
% % xlabel('kx');
% % ylabel('ky');
% axis square;
% axis tight;
% axis off;
% colormap("gray")
% hold off;