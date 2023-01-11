function obj = plate17_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r_circle = 5;
r_hex = 20;
space_sq = 20;
spacing = 58;
x1 = -N/2:spacing:N/2;
[px, py] = meshgrid(x1, x1);
obj = zeros(size(xx));

if(row == 1 && col == 1)
    obj_funct = @() draw_square(xx, yy, space_sq, r_circle, sg);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
        end
    end
elseif(row == 1 && col == 2)
    obj_funct = @() draw_square(xx, yy, space_sq, r_circle, sg);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.5)
                obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 1 && col == 3)
    obj_funct = @() draw_square(xx, yy, space_sq, r_circle, sg);
    px = px - (spacing*0.05) + (spacing*0.1)*rand(size(px, 1), size(px, 2));
    py = py - (spacing*0.05) + (spacing*0.1)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
        end
    end
elseif(row == 2 && col == 1)
    obj_funct = @() draw_hex(xx, yy, r_hex, r_circle, 0, 0, sg);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
        end
    end
elseif(row == 2 && col == 2)
    obj_funct = @() draw_hex(xx, yy, r_hex, r_circle, 0, 0, sg);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.5)
                obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 2 && col == 3)
    obj_funct = @() draw_hex(xx, yy, r_hex, r_circle, 0, 0, sg);
    px = px - (spacing*0.05) + (spacing*0.1)*rand(size(px, 1), size(px, 2));
    py = py - (spacing*0.05) + (spacing*0.1)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i, j), py(i, j)], 'bilinear');
        end
    end
elseif(row == 3 && col == 1)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    hex_x = r_hex*cosd( (0:60:300) + 30);
    hex_y = r_hex*sind( (0:60:300) + 30);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            for k = 1:size(hex_x, 2)
                rand_val = randn(1, 1);
                if(rand_val >= 0.2)
                    obj = obj + imtranslate(obj_funct(), [hex_x(k)+px(i, j), hex_y(k)+py(i, j)], 'bilinear');
                end
            end
        end
    end
elseif(row == 3 && col == 2)
    obj_funct1 = @() draw_square(xx, yy, space_sq, r_circle, sg);
    obj_funct2 = @() draw_hex(xx, yy, r_hex, r_circle, 0, 0, sg);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.5)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
            end
            
        end
    end
elseif(row == 3 && col == 3)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    hex_x = r_hex*cosd( (0:60:300) + 30);
    hex_y = r_hex*sind( (0:60:300) + 30);
    
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            for k = 1:size(hex_x, 2)
                px_offset = -1*(spacing*0.025) + (spacing*0.05)*rand(1, 1);
                py_offset = -1*(spacing*0.025) + (spacing*0.05)*rand(1, 1);
                obj = obj + imtranslate(obj_funct(), [hex_x(k)+px(i, j)+px_offset, hex_y(k)+py(i, j)+py_offset], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 1)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    hex_x = r_hex*cosd( (0:60:300) + 30);
    hex_y = r_hex*sind( (0:60:300) + 30);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            skip_val = randi(6);
            for k = 1:size(hex_x, 2)
                if(k ~= skip_val)
                    obj = obj + imtranslate(obj_funct(), [hex_x(k)+px(i, j), hex_y(k)+py(i, j)], 'bilinear');
                end
            end
        end
    end
elseif(row == 4 && col == 2)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    hex_x = r_hex*cosd( (0:60:300) + 30);
    hex_y = r_hex*sind( (0:60:300) + 30);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            skip_val = randperm(6, 2);
            skip_val = sort(skip_val);
            count = 1;
            for k = 1:size(hex_x, 2)
                if(count <= 2 && k ~= skip_val(count))
                    obj = obj + imtranslate(obj_funct(), [hex_x(k)+px(i, j), hex_y(k)+py(i, j)], 'bilinear');
                else
                    count = count + 1;
                    if(count == 3); count = 1; end
                end
            end
        end
    end
elseif(row == 4 && col == 3)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    hex_x = r_hex*cosd( (0:60:300) + 30);
    hex_y = r_hex*sind( (0:60:300) + 30);
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            skip_val = randperm(6, 3);
            skip_val = sort(skip_val);      
            count = 1;
            for k = 1:size(hex_x, 2)
                if(count <= 3 && k ~= skip_val(count))
                    obj = obj + imtranslate(obj_funct(), [hex_x(k)+px(i, j), hex_y(k)+py(i, j)], 'bilinear');
                else
                    count = count + 1;
                    if(count == 4); count = 2; end
                end
            end
        end
    end
end


end