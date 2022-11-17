num_pts = 6;
mat_size_x = 812;
mat_size_y = 812;
radius = 140*2;
if(mod(num_pts,2) == 0)
    angles = linspace(pi/2, (5*pi)/2, num_pts + 1);
else
    angles = linspace(-pi/2, (3/2)*pi, num_pts);
end
mid_x = (mat_size_x)/2;
mid_y = (mat_size_y)/2;
px = [];
py = [];
for i = 1:length(angles)
    [x, y] = pol2cart(angles(i), radius);
    x = round(x);
    y = round(y);
    x = x + mid_x;
    y = y + mid_y;
    py(i) = y;
    px(i) = x;
end

px
py