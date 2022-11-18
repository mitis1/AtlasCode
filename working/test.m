% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
s = 30; % side length
n = 6; % number of sides
N = 812;
x = (-N/2):(N/2-1);
[xx,yy] = meshgrid( x, x );
r = s/(2*sin(pi/n));
theta = linspace(0, 2*pi, n+1);
theta(end) = [];
sg = 5;

px = r .* cos(theta);
py = r .* sin(theta);

obj = double(poly2mask(px+N/2, py+N/2, N, N));

obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');

figure
imagesc(obj)
% obj = zeros(size(xx));
% for i = 1:n
%     j = i + 1;
%     if (j > size(px, 2)); j = 1; end
%     m = (py(j)-py(i))/(px(j)-px(i));
% %     m2 = 
%     obj1 = -(erf( (m*(abs(xx-px(i))-s) - (abs(yy-py(i))-s))/sg) );
%     if(i == 1); obj = obj1; continue; end
%     obj = obj .* obj1;
% end

figure
imagesc(obj)
% im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
% 
% im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
