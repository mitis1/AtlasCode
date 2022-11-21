function obj = plate1_obj_v2(N, is_circle, r_circle, spacing, x_range, y_range, sg)
    x = (-N/2):(N/2-1);
    [xx, yy] = meshgrid(x, x);
    circle = @(x0,y0, r, sg) (sqrt((xx-x0).^2+(yy-y0).^2)-r);
    total_spacing = spacing/2;
    if(spacing == 0)
        px = [0];
        py = [0];
    else
        px = [-total_spacing, total_spacing + 1];
        py = [0, 0];
    end
    
    obj = zeros([N N]);
    for i = 1:size(px, 2)
        if(is_circle)
            obj = obj + circle(px(i), py(i), r_circle, sg);
        else
            obj((py(i)-y_range+1+N/2):(py(i)+y_range+N/2) ,(px(i)-x_range+1+N/2):(px(i)+x_range+N/2)) = 1;
        end
    end
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
end