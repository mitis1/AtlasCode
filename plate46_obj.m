function obj = plate46_obj(row, col, N, sg)
% disorder_px(angle, scale_a2, scale_div, pts, line, num_pts, N)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

r_circle = 5;
obj_funct = @() draw_circle(xx, yy, r_circle, sg);

if(row == 1 && col == 1)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [];
line = false;
num_pts = 1;
elseif(row == 1 && col == 2)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [2,4,6];
line = false;
num_pts = 3;
elseif(row == 1 && col == 3)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [1,2,6];
line = false;
num_pts = 7;
elseif(row == 2 && col == 1)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [1,2,3,4,5,6];
line = false;
num_pts = 5;
elseif(row == 2 && col == 2)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [1,2,6];
line = true;
num_pts = 1;
elseif(row == 2 && col == 3)
angle = 120;
scale_a2 = 2;
scale_div = 3;
pts = [3,4,5];
line = true;
num_pts = 1;
elseif(row == 3 && col == 1)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [];
line = false;
num_pts = 3;
elseif(row == 3 && col == 2)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [1,2,6];
line = false;
num_pts = 1;
elseif(row == 3 && col == 3)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [1,2,6];
line = false;
num_pts = 5;
elseif(row == 4 && col == 1)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [1,2,3,4,5,6];
line = false;
num_pts = 5;
elseif(row == 4 && col == 2)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [1,2,6];
line = true;
num_pts = 1;
elseif(row == 4 && col == 3)
angle = 120;
scale_a2 = 1;
scale_div = 1;
pts = [1,2,3,4,5,6];
line = true;
num_pts = 1;
end

[px, py] = disorder_px(angle, scale_a2, scale_div, pts, line, num_pts, N);
for i = 1:size(px, 1)
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
end

end