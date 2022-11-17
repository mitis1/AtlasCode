function obj = plate8_obj(N, r, sg, row, col, spacing)
% px_1 = [-2   -70    58   -28    16     6];
% py_1 = [68    24    42   -10    16   -62];
% px_2 = [60    28   -24   -50   -50     2];
% py_2 = [18    70    68    42   -10   -44];
% px_3 = [-52     0    38   -21    19    70];
% py_3 = [26    40    96   -67   -12     1];
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
circle = @(x0,y0) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;

if(col == 1)
    px = [-2   -70    58   -28    16     6];
    py = [68    24    42   -10    16   -62];
elseif(col == 2)
    px = [60    28   -24   -50   -50     2];
    py = [18    70    68    42   -10   -44];
elseif(col == 3)
    px = [-52     0    38   -21    19    70];
    py = [26    40    96   -67   -12     1];
end

if(row == 2)
    py = py - spacing/2;
    py1 = py + spacing/2 + 1;
    px = [px px];
    py = [py py1];
elseif(row == 3)
    py = py - spacing/2;
    py1 = py + spacing/2 + 1;
    px = [px (-1.*px)];
    py = [py (-1.*py1)];
elseif(row == 4)
    py = py - spacing/2;
    py1 = py + spacing/2 + 1;
    px = [px (px)];
    py = [py (-1.*py1)];
end

for i = 1:size(px, 2)
    obj = obj + circle(px(i), py(i));
end
end