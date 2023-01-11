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
obj_funct = @() soft_circle(xx, yy, r, sg);
t = table;
% for k = 1:5
%     thetad = 72*(k-1);
%     t_a = aTriangle(0,cosd(thetad) + 1i*sind(thetad),[]);
%     t_ap = apTriangle(0,t_a.Right,[]);
%     t = [t ; t_a ; t_ap];
% end
t = aTriangle(0,cosd(0) + 1i*sin(0), []);
for k = 1:7
    t = decomposeTriangles(t);
%     k
end
% showTriangles(t);
px = [real(t.Apex); real(t.Left); real(t.Right)];
py = [imag(t.Apex); imag(t.Left); imag(t.Right)];

ratio = (N*1.5)/min(max(px) - min(px), max(py) - min(py));
px = px * ratio;
py = py * ratio;
px = px - N*2;
py = py - N*2;
% px = px - (max(py) - min(py))/2 - 100;
% py = py - (max(py) - min(py))/2 - 100;
obj = zeros(size(xx));
for i = 1:size(px,1)
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
end

% figure
% scatter(px, py, 'filled');



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



mask(mask>1) = mask(mask>1)/2;

im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);

im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
