function obj = plate42_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

spacing = 58;
x1 = -N/2:spacing:N/2;
[px, py] = meshgrid(x1, x1);

r_circle = 5;
w = 20;
h = 20;
r_circle2 = 10;
obj_funct1 = @() draw_circle(xx, yy, r_circle, sg);
% obj_funct2 = @() draw_rectangle(xx, yy, w, h, sg);
obj_funct3 = @() draw_circle(xx, yy, r_circle2, sg);

if(row == 1 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.9)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 1 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.1)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 1 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val <= 0.95)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 2 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.9)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 2 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.1)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 2 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val <= 0.95)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 3 && col == 1)
    alpha = 0.1;
    beta = 0.3;
elseif(row == 3 && col == 2)
    alpha = 0.1;
    beta = 0.5;
elseif(row == 3 && col == 3)
    for j = 1:size(px, 2)
        for i = 1:size(px, 1)
            if(mod(j,4) == 0)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 4 && col == 1)
    for j = 1:size(px, 2)
        for i = 1:size(px, 1)
            if(mod(j,2) == 0)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 4 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            if(mod(i,2) == 0 )
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 4 && col == 3)
    count = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            if(count <= 4)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                count = count + 1;
            else
                obj = obj + imtranslate(obj_funct3(), [px(i, j), py(i, j)], 'bilinear');
                count = count - 1;
            end
        end
    end
    return
end

% col 3
sz1 = 34;
grid = zeros([sz1, sz1]);
grid2 = zeros([sz1, sz1]);
gamma = 1-beta-alpha;
beta = beta - alpha;
% delta = 1-alpha;
delta = 0;

for i = 1:size(grid, 1)
    rand_val = rand(1,1);
    rand_val2 = rand(1,1);
    if(row == 1 || row == 4); pr = 0.5; else; pr = 0; end
    if(rand_val <= pr)
        grid(1,i) = 1;
    else
        grid2(1,i) = 1;
    end
    if(rand_val2 <= pr)
        grid(i,1) = 1;
    else
        grid2(1,i) = 1;
    end
end
grid(1,1) = 0;
grid(1,2) = 0;
grid2(1,1) = 0;
grid2(1,2) = 0;
for i = 2:size(grid, 1)
    for j = 2:size(grid, 2)
        rand_val = rand(1,1);
        pr = alpha + beta*grid(i-1,j)+gamma*grid(i,j-1)+delta*grid(i-1,j)*grid(i,j-1);
        if(rand_val <= pr)
            grid(i,j) = 1;
        else
            grid2(i,j) = 1;
        end
    end
end
grid = grid(10:sz1-11, 10:sz1-11);
grid2 = grid2(10:sz1-11, 10:sz1-11);
[py, px] = find(grid);
[py2, px2] = find(grid2);
 
ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;

ratio = N/max(max(px2)-min(px2), max(py2)-min(py2));
px2 = px2 .* ratio;
py2 = py2 .* ratio;
px2 = px2 - (max(px2)+min(px2))/2;
py2 = py2 - (max(py2)+min(py2))/2;

obj = zeros(size(xx));
for i = 1:size(px,1)
    obj = obj + imtranslate(obj_funct1(), [px(i), py(i)], 'bilinear');
end
for i = 1:size(px2, 1)
    obj = obj + imtranslate(obj_funct3(), [px2(i), py2(i)], 'bilinear');
end
end