% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)


N = 812;
N_padded = 4096;
sg = 2;
theta_curr = 0;
x_shift = 50;
angle1 = 360/10;
iter = 6;

x = -N/2:N/2-1;
[xx,yy] = meshgrid(x,x);
r = 5;
sg = 2;
pattern = ['[','N',']','+','+','[','N',']', ...
    '+','+','[','N',']','+','+','[','N',']','+','+','[','N',']'];
m_rule = ['O','F','+','+','P','F','-','-','-','-',...
    'N','F','[','-','O','F','-','-','-','-','M','F',']','+','+'];
n_rule = ['+','O','F','-','-','P','F','[','-','-','-','M','F','-','-','N','F',']','+'];
o_rule = ['-','M','F','+','+','N','F','[','+','+','+','O','F','+','+','P','F',']','-'];
p_rule = ['-','-','O','F','+','+','+','+','M','F','[','+','P','F','+','+','+','+','N','F',']','-','-','N','F'];
obj_funct = @() soft_circle(xx, yy, r, sg);
N2 = 1600;
x1 = -N2/2:N2/2-1;
[xx1, yy1] = meshgrid(x1, x1);
obj_funct2 = @() soft_circle(xx1, yy1, r, sg);
pos = [0,0];
obj = zeros(size(xx));
obj2 = zeros(size(xx1));
stack(:,:,1) = obj;
stack_level = 2;
pos_stack(:,:,1) = pos;
for i = 1:iter
    new_pattern = [];
    idx = 1;
    for j = 1:size(pattern, 2)
%         if(j == size(pattern,2)); s = j; else; s=j+1; end
        if(pattern(j) == 'M')
            new_pattern = [new_pattern, m_rule];
        elseif(pattern(j) == 'N')
            new_pattern = [new_pattern, n_rule];
        elseif(pattern(j) == 'O')
            new_pattern = [new_pattern, o_rule];
        elseif(pattern(j) == 'P')
            new_pattern = [new_pattern, p_rule];
        elseif(pattern(j) == 'F')
            new_pattern = new_pattern;
        else
            new_pattern = [new_pattern, pattern(j)];
        end
    end
    pattern = new_pattern;
end
theta_stack(1) = theta_curr;
% 
for i = 1:size(pattern,2)
    if(pattern(i) == 'F')
        obj2 = obj2 + imtranslate(obj_funct2(), pos, 'bilinear');
%         obj = obj + imtranslate(obj_funct(), pos, 'bilinear');
%         if( (round(pos(1))+N/2) <= N && (round(pos(2))+N/2 <= N) && round(pos(1))+N/2 > 0 && round(pos(2))+N/2 > 0)
%             if( obj( round(pos(1))+N/2, round(pos(2))+N/2 ) == 0 )
%                 obj2 = obj2 + imtranslate(obj_funct2(), pos, 'bilinear');
% %                 obj = obj + imtranslate(obj_funct(), pos, 'bilinear');
%             end
%         end
%         obj2 = obj2 + imtranslate(obj_funct2(), pos, 'bilinear');
        pos(1) = pos(1) + x_shift * cosd(theta_curr);
        pos(2) = pos(2) + x_shift * sind(theta_curr);
        obj2 = obj2 + imtranslate(obj_funct2(), pos, 'bilinear');
%         if( (round(pos(1))+N/2) <= N && (round(pos(2))+N/2 <= N) && round(pos(1))+N/2 > 0 && round(pos(2))+N/2 > 0)
%             if( obj( round(pos(1))+N/2, round(pos(2))+N/2 ) == 0 )
%                 obj2 = obj2 + imtranslate(obj_funct2(), pos, 'bilinear');
% %                 obj = obj + imtranslate(obj_funct(), pos, 'bilinear');
%             end
%         end
    elseif(pattern(i) == '+')
%         obj = imrotate(obj, angle, 'bilinear', 'crop');
        theta_curr = theta_curr + angle1;
    elseif(pattern(i) == '-')
%         obj = imrotate(obj, angle, 'bilinear', 'crop');
        theta_curr = theta_curr - angle1;
    elseif(pattern(i) == '[')
%         stack(:,:,stack_level) = obj;
        pos_stack(:,:,stack_level) = pos;
        theta_stack(stack_level) = theta_curr;
        stack_level = stack_level+1;
    elseif(pattern(i) == ']')
        stack_level = stack_level - 1;
%         obj = obj + stack(:,:,stack_level);
        pos = pos_stack(:,:,stack_level);
        theta_curr = theta_stack(stack_level);
    end
%     obj2(obj2>2) = obj2(obj2>2)/3;
%     obj2(obj2>1) = obj2(obj2>1)/2;
    figure(1)
        imagesc(obj2)
    disp(pos)
end



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


dispobj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
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
obj = imnoise(obj, 'gaussian', noise_mean, noise_variance);
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
