function obj = plate25_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x,x);
r = 7;
obj_funct = @() draw_circle(xx, yy, r, sg);
r_mask = 125;
circle_space = 150;
if(row == 1)
    mask = draw_circle(xx, yy, r_mask, sg);
else
    mask = imtranslate(draw_circle(xx, yy, r_mask, sg), [-circle_space, 0], 'bilinear') + ...
        imtranslate(draw_circle(xx, yy, r_mask, sg), [circle_space, 0], 'bilinear');
end
obj = zeros(size(xx));
spacing = 29;
if(row == 1 && col == 1)
    obj = mask;
elseif(row == 1 && col == 2)
    y = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [y(i), y(j)], 'bilinear');
        end
    end
elseif(row == 1 && col == 3)
    y = -N/2:spacing*(sqrt(3)/2):N/2;
    x = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        if(mod(i, 2) == 1); offset = spacing/2; else; offset = 0; end
        for j = 1:size(x, 2)
            obj = obj + imtranslate(obj_funct(), [x(j)+offset, y(i)], 'bilinear');
        end
    end
elseif(row == 2 && col == 1)
    obj = mask;
elseif(row == 2 && col == 2)
    y = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [y(i), y(j)], 'bilinear');
        end
    end
elseif(row == 2 && col == 3)
    y = -N/2:spacing*(sqrt(3)/2):N/2;
    x = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        if(mod(i, 2) == 1); offset = spacing/2; else; offset = 0; end
        for j = 1:size(x, 2)
            obj = obj + imtranslate(obj_funct(), [x(j)+offset, y(i)], 'bilinear');
        end
    end
elseif(row == 3 && col == 1)
    y = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [y(i), y(j)], 'bilinear');
        end
    end
    obj1 = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [-circle_space, 0], 'bilinear');
    obj = zeros(size(xx));
    y = -N/2:spacing:N/2;
    x = -N/2:spacing*1.5:N/2;
    for i = 1:size(x, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [x(i), y(j)], 'bilinear');
        end
    end
    obj = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [circle_space, 0], 'bilinear');
    obj = obj + obj1;
elseif(row == 3 && col == 2)
    spacing = 58;
    y = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [y(i), y(j)], 'bilinear');
        end
    end
    obj1 = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [-circle_space, 0], 'bilinear');
    obj = zeros(size(xx));
    r2 = 4;
    obj_funct2 = @() draw_circle(xx, yy, r2, sg);
    for i = 1:200
        obj = obj + imtranslate(obj_funct2(), [N*rand(1,1)-N/2, N*rand(1,1)-N/2], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
    obj = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [circle_space, 0], 'bilinear');
    obj = obj + obj1;
elseif(row == 3 && col == 3)
    y = -N/2:spacing:N/2;
    for i = 1:size(y, 2)
        for j = 1:size(y, 2)
            obj = obj + imtranslate(obj_funct(), [y(i), y(j)], 'bilinear');
        end
    end
    obj1 = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [-circle_space, 0], 'bilinear');
    obj = zeros(size(xx));
    spacing = 58;
    x = -N/2:spacing:N/2;
    r2 = 15;
    obj_funct2 = @() draw_circle(xx, yy, r2, sg);
    for i = 1:size(x, 2)
        for j = 1:size(x, 2)
            obj = obj + imtranslate(obj_funct2(), [x(i), x(j)], 'bilinear');
        end
    end
    obj = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [circle_space, 0], 'bilinear');
    obj = obj + obj1;
elseif(row == 4 && col == 1)
    for i = 1:400
        obj = obj + imtranslate(obj_funct(), [N*rand(1,1)-N/2, N*rand(1,1)-N/2], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 2)
    px_obj = [-10, 10, -10, 10]*0.5;
    py_obj = [-60, -20, 20, 60]*0.5;
    px = -N/2:80:N/2;
    py = -N/2:50:N/2;
    for k = 1:size(px,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [px(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 3)
    obj = zeros(size(xx));
    px_obj = [-10, 10, -10, 10]*0.5;
    py_obj = [-60, -20, 20, 60]*0.5;
    px = -N/2:80:N/2;
    py = -N/2:50:N/2;
    for k = 1:size(px,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [px(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
    obj1 = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [-circle_space, 0], 'bilinear');
    obj = imrotate(obj, 45, 'bilinear', 'crop');
    obj = obj .* imtranslate(draw_circle(xx, yy, r_mask, sg), [circle_space, 0], 'bilinear');
    obj = obj + obj1;
end
obj = obj .* mask;
end