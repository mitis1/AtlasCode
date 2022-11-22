function obj = plate12_obj(row, col, N, sg)
px_img = [-7    12    16    10   -17];
py_img = [-39   -55   -25    -1    -2];
% N, r, px_spacing, py_spacing, slope, sg, row, col,y_range, x_range, tilt_angle
px_spacing = 54;
py_spacing = 54;
slope = -4;
x_range = 100;
y_range = 150;
tilt_angle = 45;
if(row == 3 || (row == 1 && col == 1))
    r = 10;
elseif(row == 1 && col == 2)
    r = 15;
else
    r = 8;
end

x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
circle_funct = @( ) draw_circle(xx, yy, r, sg);
line = @(y, slope, int) y*slope + int; 
obj = zeros(size(xx));

if(row == 4 && col == 1)
    obj(xx >= -x_range & xx <= x_range ...
    & yy >= -y_range & yy <= y_range) = 1;
    obj = imrotate(obj, tilt_angle, "bicubic", "crop");
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
    return;
end
if(row == 1 && col == 2)
    obj = obj + circle_funct( );
    return;
end
if(col == 1 && (row == 2 || row == 3))
    for k = 1:size(px_img, 2)
        obj = obj + imtranslate(circle_funct(), [px_img(k), py_img(k)], 'bilinear');
    end
end
if(col == 2 && (row == 2 || row == 3))
    px_int = [-px_spacing, px_spacing, -px_spacing, px_spacing];
    py = [-py_spacing, -py_spacing, py_spacing+1, py_spacing+1];
    px = line(py, slope, px_int);
    for i = 1:size(py, 2)
        for k = 1:size(px_img, 2)
            obj = obj + imtranslate(circle_funct(), [px(i)+px_img(k), py(i)+py_img(k)], 'bilinear');
        end
    end
end

% lines
px_int = -N/2-px_spacing:px_spacing:N/2-1+2*px_spacing;
slope = -1/4;
py = -N/2-py_spacing:py_spacing:N/2-1+py_spacing;

obj = zeros(size(xx));
for i = 1:size(py,2)
    for j = 1:size(px_int,2)
        px = line(py(i), slope, px_int(j));
        if(col == 3 && row ~= 1)
            for k = 1:size(px_img, 2)
                obj = obj + imtranslate(draw_circle(xx, yy, r, sg), [px+px_img(k), py(i)+py_img(k)], 'bilinear');
            end
        else
            obj = obj + imtranslate(draw_circle(xx, yy, r, sg), [px+px_img(k), py(i)+py_img(k)], 'bilinear');
        end
    end
end
if(row == 4)
    mask = draw_rectangle(xx, yy, x_range*2, y_range*2, sg);
    mask = imrotate(mask, tilt_angle, "bicubic", "crop");
    obj = obj .* mask;
end
end