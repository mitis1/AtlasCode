% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
row = 3;
col = 3;
N1 = 812;
sz = 100;
sg = 5;
N = 5;
x = -N1/2:N1/2-1;
[xx, yy] = meshgrid(x, x);

rr = sqrt( (xx).^2+ (yy).^2*2 );
im = erfc( (rr-200)/sg ) / 2;
figure
imagesc(x,x,im)
% im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
% 
% im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
