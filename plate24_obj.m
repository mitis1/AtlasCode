function obj = plate24_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 3;
w = 1;
h = 3;
a = 3.6;
r_helix = 50;
if(row == 2)
    obj_funct = @() draw_circle(xx, yy, r, sg);
else
    obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
end

if(row == 1 && col == 1)
elseif(row == 1 && col == 2)
elseif(row == 1 && col == 3)
elseif(row == 2 && col == 1)
elseif(row == 2 && col == 2)
elseif(row == 2 && col == 3)
elseif(row == 3 && col == 1)
elseif(row == 3 && col == 2)
elseif(row == 3 && col == 3)
elseif(row == 4 && col == 1)
elseif(row == 4 && col == 2)
elseif(row == 4 && col == 3)
end
end