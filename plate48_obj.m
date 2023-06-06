function obj = plate48_obj(row, col, N, sg)

obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

spacing = 58;
x1 = -N/2:spacing:N/2;
[px, py] = meshgrid(x1, x1);

r_circle = 5;
r_circle2 = 10;
obj_funct1 = @() draw_circle(xx, yy, r_circle, sg);
obj_funct3 = @() draw_circle(xx, yy, r_circle2, sg);

if(row == 1 && col == 1)
magx = 1;
magy = 0.25;
probx = 0;
proby = .25;
elseif(row == 1 && col == 2)
magx = 0;
magy = 0.25;
probx = 0;
proby = 0.75;
elseif(row == 1 && col == 3)
magx = 0;
magy = 0.5;
probx = 0;
proby = 0.25;
elseif(row == 2 && col == 1)
magx = 0.25;
magy = 0;
probx = 0.25;
proby = 0;
elseif(row == 2 && col == 2)
magx = 0.25;
magy = 0;
probx = 0.5;
proby = 0;
elseif(row == 2 && col == 3)
magx = 0.5;
magy = 0;
probx = 0.25;
proby = 0;
elseif(row == 3 && col == 1)
magx = 0.25;
magy = 0.25;
probx = 0.25;
proby = 0.25;
elseif(row == 3 && col == 2)
magx = 0.25;
magy = 0.25;
probx = 0.75;
proby = 0.75;
elseif(row == 3 && col == 3)
magx = 0.5;
magy = 0.25;
probx = 0.25;
proby = 0.25;
elseif(row == 4 && col == 1)
magx = 0.25;
magy = 0.5;
probx = 0.25;
proby = 0.25;
elseif(row == 4 && col == 2)
magx = 0.5;
magy = 0.5;
probx = 0.25;
proby = 0.25;
elseif(row == 4 && col == 3)
magx = 0.5;
magy = 0.5;
probx = 0.75;
proby = 0.75;
end

count = 1;
for i = 1:size(px, 1)
    for j = 1:size(px, 2)
        if(count <= 4)
            obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            count = count + 1;
        else
            rand_offsetx = rand(1,1)*spacing*magx*2-spacing*magx;
            rand_offsety = rand(1,1)*spacing*magy*2-spacing*magy;
            if(rand(1,1) <= probx)
                if(rand(1,1) <= proby)
                    obj = obj + imtranslate(obj_funct3(), [px(i, j)+rand_offsetx, py(i, j)+rand_offsety], 'bilinear');
                    count = count - 1;
                else
                    obj = obj + imtranslate(obj_funct3(), [px(i, j)+rand_offsetx, py(i, j)], 'bilinear');
                    count = count - 1;
                end
            elseif(rand(1,1) <= proby)
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)+rand_offsety], 'bilinear');
                count = count - 1;
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
                count = count - 1;
            end
        end
    end
end
end