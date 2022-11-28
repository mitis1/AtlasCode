% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
row = 4;
col = 3;
N = 812;
sg = 5;
% sz = 100;
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x,x);
r = 80;
sz = N/7-1;
px = linspace(-N/2-0.5+w/2, N/2-0.5, 14);
py = linspace(-N/2-0.5, N/2-0.5, 8);
mask = zeros(size(xx));
prev = 0; offset = w/2;
for i = 1:size(py, 2)
    for j = 1:size(px,2)
        if(prev == 0)
            mask = mask + imtranslate(draw_Ngon(xx, yy, 8, sz-1, sg), [px(j), py(i)], "bilinear");
            prev = 1;
            else; prev = 0;
        end
    end
end
% mask(mask>1) = mask(mask>1)/2;
figure
imagesc(x,x,mask)
% im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
% 
% im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
