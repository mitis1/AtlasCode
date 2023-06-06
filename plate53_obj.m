function obj = plate53_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
w = 20;
h = 80;
obj_funct = @() draw_lq(xx, yy, w, h, sg);

spacingx = 58;
spacingy = 116;
x1 = -N/2+spacingx/2:spacingx:N/2-1+spacingx/2;
y1 = -N/2+spacingy/2:spacingy:N/2-1+spacingy/2;
[px, py] = meshgrid(x1, y1);
obj = zeros(size(xx));
if(row == 1 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/10;
            randy = rand(1,1)*spacingy/10;
            obj = obj + imtranslate(obj_funct(), [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 1 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/5;
            randy = rand(1,1)*spacingy/5;
            obj = obj + imtranslate(obj_funct(), [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 1 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rot_val = rand(1,1)*10-5;
            obj1 = imrotate(obj_funct(), rot_val, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j), py(i,j)], 'bilinear');
        end
    end
elseif(row == 2 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/5;
            randy = rand(1,1)*spacingy/5;
            obj1 = imrotate(obj_funct(), 30, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 2 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/5;
            randy = rand(1,1)*spacingy/5;
            rot_val = rand(1,1)*10-5;
            obj1 = imrotate(obj_funct(), rot_val, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 2 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx*3;
            randy = rand(1,1)*spacingy*3;
            obj = obj + imtranslate(obj_funct(), [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 3 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx*3;
            randy = rand(1,1)*spacingy*3;
            rot_val = rand(1,1)*90-45;
            obj1 = imrotate(obj_funct(), rot_val, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 3 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx;
            obj = obj + imtranslate(obj_funct(), [px(i,j)+randx, py(i,j)], 'bilinear');
        end
    end
elseif(row == 3 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randy = rand(1,1)*spacingy;
            rot_val = rand(1,1)*10-5;
            obj1 = imrotate(obj_funct(), rot_val, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j), py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 4 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx*3;
            rot_val = rand(1,1)*30-15;
            obj1 = imrotate(obj_funct(), rot_val, 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)], 'bilinear');
        end
    end
elseif(row == 4 && col == 2)
    y_val = -N/2:spacingy:N/2-1;
    rot_val = 90*tan((2*pi*y_val)/(N/4));
    for i = 1:size(px, 1) 
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/5;
            randy = rand(1,1)*spacingy/5;
            obj1 = imrotate(obj_funct(), rot_val(i), 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
elseif(row == 4 && col == 3)
    y_val = -N/2:spacingy:N/2-1;
    rot_val = 180*sin((2*pi*y_val)/(N/4));
    for i = 1:size(px, 1) 
        for j = 1:size(px, 2)
            randx = rand(1,1)*spacingx/5;
            randy = rand(1,1)*spacingy/5;
            obj1 = imrotate(obj_funct(), rot_val(i), 'bilinear','crop');
            obj = obj + imtranslate(obj1, [px(i,j)+randx, py(i,j)+randy], 'bilinear');
        end
    end
end
end