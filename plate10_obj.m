function obj = plate10_obj(row, col, N, sg)
    r = 20;
    spacing = 40;
    if(row == 1)
        rows = 1;
    elseif(row == 2)
        rows = 2;
    elseif(row == 3)
        rows = 4;
    elseif(row == 4)
        rows = 6;
    end
    if(col == 1)
        cols = 1;
    elseif(col == 2)
        cols = 3;
    elseif(col == 3)
        cols = 5;
    end
    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x, x);
    circle_funct = @() draw_circle(xx, yy, r, sg);
    
    px = [];
    py = [];
    x_offset = ((cols-1)/2)*(2*r + 1 + spacing);
    y_offset = (rows/2)*(spacing + 2*r + 1) - (spacing/2);
    circle_spacing = r*2 + 1 + spacing;
    y_idx = -y_offset;
    x_idx = -x_offset;
    inc = 1;
    for i = 1:rows
        for j = 1:cols
            px(inc) = x_idx;
            py(inc) = y_idx;
            x_idx = x_idx + circle_spacing;
            inc = inc + 1;
        end
        x_idx = -x_offset;
        y_idx = y_idx + circle_spacing;
        
    end
%     x_offset = ((cols-1)/2)*(2*r + 1 + spacing);
%     y_offset = (rows/2)*(spacing + 2*r + 1) - (spacing/2);
%     circle_spacing = r*2 + 1 + spacing;
%     px = linspace(-x_offset,-x_offset + circle_spacing * cols, cols);
%     py = linspace(-y_offset, -y_offset + circle_spacing * rows, rows);
    if(rows == 1 && cols == 1)
        px = 0;
        py = 0;
    elseif(rows == 1)
        py = zeros(size(px));
    elseif(cols == 1)
        px = zeros(size(py));
    end
    
    obj = zeros([N N]);
    for i = 1:size(px, 2)
        for(j = 1:size(py,2))
            obj = obj + imtranslate(circle_funct(), [px(i), py(j)], 'bilinear');
        end
    end
end