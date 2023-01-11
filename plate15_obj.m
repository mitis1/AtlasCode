function obj = plate15_obj(row, col, N, sg)
spacing = 58;
% spacing_y = 29;
 x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 5;
circle_funct = @( ) draw_circle(xx, yy, r, sg);

if(row == 1 && col == 1)
    y = -N/2:spacing:N/2;
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, y);
elseif(row == 1 && col == 2)
    y = -N/2:spacing/2:N/2;
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, y);
elseif(row == 1 && col == 3)
    y = -N/2:spacing*(sqrt(3)/2):N/2;
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, y);
    for i = 1:size(y, 2)
        if(mod(i, 2) == 1)
            px(i, :) = px(i, :) + spacing/2;
        end
    end
elseif(row == 2 && col == 1)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
elseif(row == 2 && col == 2)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) - err + (err*2)*rand(size(px, 1), 1);
    end
elseif(row == 2 && col == 3)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.25 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) - err + (err*2)*rand(size(px, 1), 1);
    end
elseif(row == 3 && col == 1)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
elseif(row == 3 && col == 2)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
    for i = 1:size(py, 2)
        py(i, :) = py(i,:) - err + (err*2)*rand(1,size(py, 2));
    end
elseif(row == 3 && col == 3)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.25 * spacing;
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
    for i = 1:size(py, 2)
        py(i, :) = py(i,:) - err + (err*2)*rand(1,size(py, 2));
    end
elseif(row == 4 && col == 1)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
elseif(row == 4 && col == 2)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) - err + (err*2)*rand(size(px, 1), 1);
    end
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
    for i = 1:size(py, 1)
        py(i,:) = py(i, :) - err + (err*2)*rand(1,size(py, 2));
    end
elseif(row == 4 && col == 3)
    x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.25 * spacing;
    px = px - err + (err*2)*rand(size(px, 1), size(px, 2));
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) - err + (err*2)*rand(size(px, 1), 1);
    end
    py = py - err + (err*2)*rand(size(py, 1), size(py, 2));
    for i = 1:size(py, 1)
        py(i,:) = py(i, :) - err + (err*2)*rand(1,size(py, 2));
    end
end

obj = zeros(size(xx));
for i = 1:size(px,1)
    for j = 1:size(px, 2)
    obj = obj + imtranslate(circle_funct(), [px(i, j), py(i, j)], 'bilinear');
    end
end
end