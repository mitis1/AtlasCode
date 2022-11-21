% clear;
% clc;
% img = imread('img.png');
% img = imresize(img, [812 812]);
% figure;
% imagesc(img)
row = 3;
col = 1;

N = 812;
sg = 5;
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 25;
r_outer = 140;
r_hex = 80;
circle_funct = @( ) draw_circle(xx, yy, r, sg);

if(row == 1 && col == 1)
    rm_pts = [];
    rm_hex = [1, 2, 3, 4, 5, 6];
elseif(row == 1 && col == 2)
    rm_pts = [1, 2, 3, 4, 6];
    rm_hex = [1, 2, 3, 5, 6];
elseif(row == 1 && col == 3)
    rm_pts = [3,4,5];
    rm_hex = [1,2,4,5,6];
elseif(row == 2 && col == 1)
    rm_pts = [1,2,3,5,6];
    rm_hex = [1,3,4,6];
elseif(row == 2 && col == 2)
    rm_pts = [];
    rm_hex = [2,3,4,5,6,7];
elseif(row == 2 && col == 3)
    rm_pts = [];
    rm_hex = [1,2,3,4,5,7];
elseif(row == 3 && col == 1)
    rm_pts = [1,3,4,6];
    rm_hex = [2,3,5,6];
elseif(row == 3 && col == 2)
    rm_pts = [];
    rm_hex = [1,3,4,6];
elseif(row == 3 && col == 3)
    rm_pts = [];
    rm_hex = [1,3,5];
elseif(row == 4 && col == 1)
    rm_pts = [1,3];
    rm_hex = [];
elseif(row == 4 && col == 2)
    rm_pts = [1];
    rm_hex = [];
elseif(row == 4 && col == 3)
    rm_pts = [];
    rm_hex = [];
end

hex_x = r_outer*cosd( (0:60:300) );
hex_y = r_outer*sind( (0:60:300) );
hex_x(end+1) = 0;
hex_y(end+1) = 0;

px = r_hex*cosd( (0:60:300) + 30);
py = r_hex*sind( (0:60:300) + 30);

hex_count = 1;
pts_count = 1;
obj = zeros([N, N]);
if(~isempty(rm_hex) && rm_hex(length(rm_hex)) == 7)
    if(rm_hex(1) ~= 1) % two in a row
        x_avg = (hex_x(7) + hex_x(1))/2;
        hex_x = [hex_x(7) - x_avg, hex_x(1) - x_avg];
        hex_y = [0, 0];
    else % two diagonal
        x_avg = (hex_x(1) + hex_x(3))/2;
        y_avg = (hex_y(1) + hex_y(3))/2;
        hex_x = [hex_x(1) - x_avg, hex_x(3) - x_avg];
        hex_y = [hex_y(1) - y_avg, hex_y(3) - y_avg];
    end
    for j = 1:size(px,2)
        obj = obj + circle_funct(hex_x(1) + px(j), hex_y(1) + py(j));
        obj = obj + circle_funct(hex_x(2) + px(j), hex_y(2) + py(j));
    end
    return
end

for i = 1:size(px, 2)
        obj = obj + circle_funct(hex_x(i) + px(j), hex_y(i) + py(j));
end
figure
imagesc(obj)
% im_triangle = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
% 
% im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);
