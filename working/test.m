% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
N = 812;
x = (-N/2):(N/2-1);
[xx,yy] = meshgrid( x, x );
% circle = @(x0,y0, r, sg) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;
% circle = @(x0,y0, r, sg) (sqrt((xx-x0).^2+(yy-y0).^2)-r);
spacing_x = 40;
spacing_y = 50;
px = -N/2:spacing_x:N/2-1;
py = -N/2:spacing_y:N/2-1;
r = 50;
x_range = 10;
y_range = 15;
angle = 20;

obj1 = zeros([size(xx,1)*1.5, size(xx,2)*1.5]);
px = -(N*1.5)/2:spacing_x:(N*1.5)/2-1;
py = -(N*1.5)/2:spacing_y:(N*1.5)/2-1;
for i = 1:size(px, 2)
    for j = 1:size(py, 2)

    end
end

figure
imagesc(obj1)