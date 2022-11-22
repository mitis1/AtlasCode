function obj = plate10_obj(N, rows, cols, r, spacing, sg)
    circle = @(x0,y0) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;
    
    x_offset = ((cols-1)/2)*(2*r + 1 + spacing);
    y_offset = (rows/2)*(spacing + 2*r + 1) - (spacing/2);
    circle_spacing = r*2 + 1 + spacing;
    px = linspace(N/2 - x_offset, N/2 - x_offset + circle_spacing * cols, cols);
    py = linspace(N/2 - y_offset, N/2 - y_offset + circle_spacing * rows, rows);
    
    obj = zeros([N N]);
    for i = 1:size(px, 2)
        obj = obj + circle(px(i), py(i));
    end
end