% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
row = 3;
col = 3;

N = 812;
sg = 5;
r = 18;
if(col == 1)
    spacing = 200;
elseif(col == 2)
    spacing = 150;
else
    spacing = 200;
end
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
circle_funct = @() draw_circle(xx, yy, r, sg);

if(col == 1)
    px = [-2   -70    58   -28    16     6];
    py = -[68    24    42   -10    16   -62];
elseif(col == 2)
    px = [60    28   -24   -50   -50     2];
    py = [18    70    68    42   -10   -44];
elseif(col == 3)
    px = [-52     0    38   -21    19    70];
    py = [26    40    96   -67   -12     1];
end

if(row == 2)
    py1 = py + spacing/2 + 1;
    py2 = py - spacing/2;
    px = [px px];
    py = [py2 py1];
elseif(row == 3)
    py1 = py + spacing/2 + 1;
    py2 = -py - spacing/2;
    px = [px (-px)];
    py = [py2 (py1)];
elseif(row == 4)
    py1 = py + spacing/2 + 1;
    py2 = -py - spacing/2;
    px = [px (px)];
    py = [py2 (py1)];
end

obj = zeros(size(xx));
for i = 1:size(px, 2)
    obj = obj + imtranslate(circle_funct(), [px(i), py(i)],"bilinear" );
end
figure
imagesc(x,x,obj)
% im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
% 
% im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
