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
r = 5;
sg = 2;
obj_funct = @() soft_circle(xx, yy, r, sg);
gen = 5;

DIM = [N N];
BETA = -4;
u = [(0:floor(DIM(1)/2)) -(ceil(DIM(1)/2)-1:-1:1)]'/DIM(1);
% Reproduce these frequencies along ever row
u = repmat(u,1,DIM(2));
% v is the set of frequencies along the second dimension.  For a square
% region it will be the transpose of u
v = [(0:floor(DIM(2)/2)) -(ceil(DIM(2)/2)-1:-1:1)]/DIM(2);
% Reproduce these frequencies along ever column
v = repmat(v,DIM(1),1);
% Generate the power spectrum
S_f = (u.^2 + v.^2).^(BETA/2);
% Set any infinities to zero
S_f(S_f==inf) = 0;
% Generate a grid of random phase shifts
phi = rand(DIM);
% Inverse Fourier transform to obtain the the spatial pattern
x = ifft2(S_f.^0.5 .* (cos(2*pi*phi)+i*sin(2*pi*phi)));
% Pick just the real component
x = real(x);

obj = x .^ 2;

% %%
% close all;
% 
% T = pi/7; %theta
% 
% 
% a = 1;
% b = a*(sin(2*T)/sin(T));
% c = a*(sin(4*T)/sin(T));
% 
% SF = a / (a+b) ;  %scaling factor
% 
% % Prototile I:
% 
% p00 = [0,0];
% p01 = [a,0];
% p02 = [b*cos(4*T),b*sin(4*T)];
% 
% p1 = [p00' p01' p02' p00'];
% 
% figure,
% subplot(1,3,1)
% plot([p00(1,1),p01(1,1),p02(1,1),p00(1,1)],[p00(1,2),p01(1,2),p02(1,2),p00(1,2)],'k-');
% title('Title 1 (Level 0)');
% 
% % Prototile II:
% p10 = [0,0];
% p11 = [c,0];
% p12 = [b*cos(2*T),b*sin(2*T)];
% 
% p2 = [p10' p11' p12' p10'];
% 
% subplot(1,3,2)
% plot([p10(1,1),p11(1,1),p12(1,1),p10(1,1)],[p10(1,2),p11(1,2),p12(1,2),p10(1,2)],'k-');
% title('Title 2 (Level 0)');
% 
% % Prototile II:
% p20 = [0,0];
% p21 = [a,0];
% p22 = [c*cos(3*T),c*sin(3*T)];
% 
% p3 = [p20' p21' p22' p20'];
% 
% subplot(1,3,3)
% plot([p20(1,1),p21(1,1),p22(1,1),p20(1,1)],[p20(1,2),p21(1,2),p22(1,2),p20(1,2)],'k-');
% title('Title 3 (Level 0)');
% 
% 
% %Calculate indices for Level 1 tiles, Lij satands for tile i of level j
% L31 = tile3(p1,p2,p3); 
% L11 = tile1(p1,p2,p3); 
% L21 = tile2(p1,p2,p3); 
% 
% 
% %Calculate indices for Level 2 tiles, Lij satands for tile i of level j
% L11 = L11*SF;
% L21 = L21*SF;
% L31 = L31*SF;
% 
% L32 = tile3(L11,L21,L31); 
% L12 = tile1(L11,L21,L31); 
% L22 = tile2(L11,L21,L31); 
% 
% %Calculate indices for Level 3 tiles, Lij satands for tile i of level j
% L12 = L12*SF;
% L22 = L22*SF;
% L32 = L32*SF;
% 
% L33 = tile3(L12,L22,L32); 
% L13 = tile1(L12,L22,L32); 
% L23 = tile2(L12,L22,L32); 
% 
% %Calculate indices for Level 3 tiles, Lij satands for tile i of level j
% L13 = L13*SF;
% L23 = L23*SF;
% L33 = L33*SF;
% 
% L34 = tile3(L13,L23,L33); 
% L14 = tile1(L13,L23,L33); 
% L24 = tile2(L13,L23,L33); 
% 
% %Calculate indices for Level 4 tiles, Lij satands for tile i of level j
% 
% L14 = L14*SF;
% L24 = L24*SF;
% L34 = L34*SF;
% 
% L35 = tile3(L14,L24,L34); 
% L15 = tile1(L14,L24,L34); 
% L25 = tile2(L14,L24,L34); 
% 
% 
% % Plots examples of different levels
% 
% figure,
% hold on;
% for j = 0:7
% plot(L31(1,4*j+1:4*j+4),L31(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 3 (Level 1)');
% 
% 
% figure,
% hold on;
% for j = 0:10
% plot(L21(1,4*j+1:4*j+4),L21(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 2 (Level 1)');
% 
% 
% figure,
% hold on;
% for j = 0:5
% plot(L11(1,4*j+1:4*j+4),L11(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 1 (Level 1)');
% 
% 
% Z = L13; 
% [~,l] = size(Z);
% figure,
% hold on;
% for j = 0:l/4-1 
% plot(Z(1,4*j+1:4*j+4),Z(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 1 (Level 3)');
% 
% Z = L23; 
% [~,l] = size(Z);
% figure,
% hold on;
% for j = 0:l/4-1 
% plot(Z(1,4*j+1:4*j+4),Z(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 2 (Level 3)');
% 
% Z = L34; 
% [~,l] = size(Z);
% figure,
% hold on;
% for j = 0:l/4-1 
% plot(Z(1,4*j+1:4*j+4),Z(2,4*j+1:4*j+4),'k-');
% end
% hold off;
% title('Title 3 (Level 4)');


%%
% figure
% imagesc(obj)

% ratio = N/(max(px) - min(px));
% px = px .* ratio;
% py = py .* ratio;
% px = px - (N/2+min(px));
% py = py - (N/2+min(py));
% 
% obj = zeros(size(xx));
% for i = 1:size(px,1)
%     obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
% end


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
