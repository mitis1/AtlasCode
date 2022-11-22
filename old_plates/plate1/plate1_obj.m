function obj = plate1_obj(N, is_circle, r_circle, spacing, x_range, y_range, sg)
    x = (-N/2):(N/2-1);
    [xx, yy] = meshgrid(x, x);
    circle = @(x0,y0, r, sg) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;

    total_spacing = spacing/2;
    if(spacing == 0)
        px = [0];
        py = [0];
    else
        px = [-total_spacing, total_spacing + 1];
        py = [0, 0];
    end
    
    obj = zeros([N N]);
%     obj1 = zeros([N N]);
%     diffx = x_range/2;
%     diffy = y_range/2;
    for i = 1:size(px, 2)
        if(is_circle)
            obj = obj + circle(px(i), py(i), r_circle, sg);
        else
%             x1 = xx - px(i);
%             y1 = yy - py(i);
            obj((py(i)-y_range+1+N/2):(py(i)+y_range+N/2) ,(px(i)-x_range+1+N/2):(px(i)+x_range+N/2)) = 1;
%             obj = obj + obj1;
%             obj = obj + obj1;
%             obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
        end
    end
    if(~is_circle)
        obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
%         imagesc(x, x, obj);
    end

end