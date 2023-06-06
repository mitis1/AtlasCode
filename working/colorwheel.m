N = 2048;
x = -N/2:N/2-1;
L_factor = 90;
[xx, yy] = meshgrid(x,x);
[theta,r] = cart2pol(xx, yy);
obj_amp = zeros(size(r));
obj_amp(r <= 1000) = 1;
L = L_factor * (obj_amp);
a = L.*cos(theta + pi/2);
b = L.*sin(theta + pi/2);

%% CIELab
pha_rgb = lab2rgb( cat(3, L, a, b));
pha_rgb( pha_rgb>1 ) = 1;
pha_rgb( pha_rgb<0 ) = 0;
figure
hold on;
imagesc( pha_rgb);
axis square
axis off
hold off;
% imwrite( uint8(255*pha_rgb), 'colorwheel.png');

%% OKLab
lch = lab2lch(cat(3, L, a, b));
pha_rgb = lch2rgb(lch);
% pha_rgb = lin2rgb(pha_rgb);

figure
hold on;
imagesc( pha_rgb);
axis square
axis off
hold off;
