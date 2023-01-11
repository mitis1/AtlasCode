function obj = plate21_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r_circle = 5;
obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);

if(row == 1 && col == 1)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    for j = 1:size(py,2)
        for i = 1:size(px_obj,2)
            if(j == 1 && i == 1)
                continue;
            end
            obj = obj + imtranslate(obj_funct(), [px_obj(i), py(j) + py_obj(i)], 'bilinear');
        end
    end
    return;
elseif(row == 1 && col == 2)
    obj = zeros(size(xx));
    px_obj = [-10, 10, -10, 10];
    py_obj = [-60, -20, 20, 60];

    py = -250:150:250;
    for j = 1:size(py,2)
        for i = 1:size(px_obj,2)
            obj = obj + imtranslate(obj_funct(), [px_obj(i), py(j) + py_obj(i)], 'bilinear');
        end
    end
    return;
elseif(row == 1 && col == 3)
    py_obj = -1*[17.3205         0  -17.3205  -17.3205];
    px = [-10   -20   -10    10];
    obj = zeros(size(xx));
    py = -250:60:250;
    for j = 1:size(py,2)
        if(mod(j,2) == 1)
            px_obj = px + 10;
        else
            px_obj = -1*px - 10;
        end
        for i = 1:size(px_obj,2)
            obj = obj + imtranslate(obj_funct(), [px_obj(i), py(j) + py_obj(i)], 'bilinear');
        end
    end    
    return;
elseif(row == 2 && col == 1)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    x = [-20, 20];
    for k = 1:size(x,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [x(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
elseif(row == 2 && col == 2)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    for j = 1:size(py,2)
        rand_val = randperm(3, 2);
        rand_val = sort(rand_val);
        count = 1;
        for i = 1:size(px_obj,2)
            if(count <= 2 && rand_val(count) ~= i)
                obj = obj + imtranslate(obj_funct(), [px_obj(i), py(j) + py_obj(i)], 'bilinear');
            else
                count = count + 1;
                disp = rand(1,2)*10-5;
                obj = obj + imtranslate(obj_funct(), [px_obj(i)+disp(1), py(j)+py_obj(i)+disp(2)], 'bilinear');
                if(count == 3); count = 1; end
            end
        end
    end
elseif(row == 2 && col == 3)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    for j = 1:size(py,2)
        disp = rand(1,1)*20-10;
        for i = 1:size(px_obj,2)    
            obj = obj + imtranslate(obj_funct(), [px_obj(i), py(j)+py_obj(i)+disp], 'bilinear');
        end
    end
elseif(row == 3 && col == 1)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    x = [-60,-20, 20, 60];
    for k = 1:size(x,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [x(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
elseif(row == 3 && col == 2)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    y = [];
    px = [];
    for i = 1:size(py,2)
        y = [y, py_obj+py(i)];
        px = [px, px_obj];
    end
    py = y;
    wave_disp = 5*sin(linspace(0, 2*pi, size(px,2)));
    px = px + wave_disp;
    for i = 1:size(py,2)
        obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
    end
elseif(row == 3 && col == 3)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -250:60:250;
    wave_disp = 5*sin(linspace(0, 2*pi, 3*size(py,2)));
    k = 1;
    for j = 1:size(py,2)
        theta_offset = 20+70*rand(1,1);
        R_1 = [cosd(theta_offset), 0, sind(theta_offset);
                    0, 1, 0
                    -sind(theta_offset), 0, cosd(theta_offset)];
        z = zeros(size(px_obj));
        val = R_1 * [px_obj; py_obj; z];
        px_obj1 = val(1,:);
        for i = 1:size(px_obj,2)
            obj = obj + imtranslate(obj_funct(), [wave_disp(k)+px_obj1(i), py(j)+py_obj(i)], 'bilinear');
            k = k + 1;
        end
    end
elseif(row == 4 && col == 1)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -N/2:60:N/2;
    x = -N/2:40:N/2;
    for k = 1:size(x,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [x(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 2)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -N/2:60:N/2;
    x = -N/2:40:N/2;
    x = x - 10 + 20*rand(size(x,1), size(x,2));
    for k = 1:size(x,2)
        for j = 1:size(py,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [x(k)+px_obj(i), py(j) + py_obj(i)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 3)
    obj = zeros(size(xx));
    px_obj = [-10, 10, 10];
    py_obj = [-15, 0, 30];
    py = -N/2:60:N/2;
    x = -N/2:40:N/2;
    for k = 1:size(x,2)
        py1 = py + rand(1,1)*20 - 10;
        for j = 1:size(py1,2)
            for i = 1:size(px_obj,2)
                obj = obj + imtranslate(obj_funct(), [x(k)+px_obj(i), py1(j) + py_obj(i)], 'bilinear');
            end
        end
    end
end
end