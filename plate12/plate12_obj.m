function obj = plate12_obj(N, r, px_spacing, py_spacing, slope, sg, row, col,y_range, x_range, tilt_angle)

px_img = [-7    12    16    10   -17];
py_img = [-39   -55   -25    -1    -2];
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
circle = @(x0,y0) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;
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
    obj = obj + circle(0, 0);
    return;
end
if(col == 1 && (row == 2 || row == 3))
    for k = 1:size(px_img, 2)
        obj = obj + circle(px_img(k), py_img(k));
    end
end
if(col == 2 && (row == 2 || row == 3))
    px_int = [-px_spacing, px_spacing, -px_spacing, px_spacing];
    py = [-py_spacing, -py_spacing, py_spacing+1, py_spacing+1];
    px = line(py, slope, px_int);
    for i = 1:size(py, 2)
        for k = 1:size(px_img, 2)
            obj = obj + circle(px(i)+px_img(k), py(i)+py_img(k));
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
                obj = obj + circle(px+px_img(k), py(i)+py_img(k));
            end
        else
            obj = obj + circle(px+px_img(k), py(i)+py_img(k));
        end
    end
end
if(row == 4)
    mask = zeros(size(xx));
    mask(xx >= -x_range & xx <= x_range ...
    & yy >= -y_range & yy <= y_range) = 1;
    mask = imrotate(mask, tilt_angle, "bicubic", "crop");
    mask = imgaussfilt(mask, sg, 'FilterDomain', 'frequency');
    obj = obj .* mask;
end
end