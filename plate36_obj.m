function obj = plate36_obj(row, col, N, sg)
    spacing = 19;
    spacing2 = 89;
    w = 5;
%     h = 10;
    r = 5;
    sz = N/7;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    px1 = -N/2+spacing/2:spacing:N/2-1;
    [px, py] = meshgrid(px1, px1);

    if(row == 2 || row == 4)
        if(col == 1)
            obj_funct = @() draw_circle(xx, yy, r, sg);
        elseif(col == 2)
            obj_funct = @() draw_rectangle(xx, yy, w, w, sg);
        elseif(col == 3)
            obj_funct = draw_Ngon(xx, yy, 3, w, sg);
        end
    else
        obj_funct = @() draw_circle(xx, yy, r, sg);
    end
    if(row == 1)
        if(col == 1)
            obj = draw_circle(xx, yy, r*10, sg);
        elseif(col == 2)
            obj = draw_rectangle(xx, yy, w*10, w*10, sg);
        else
            obj = draw_Ngon(xx, yy, 3, w*10, sg);
        end
    return
    end

    if(col == 1)
        w = (N)/6;
        px = linspace(-N/2-0.5, N/2-0.5, 7);
        mask = zeros(size(xx));
        prev = 0;
        for i = 1:size(px, 2)
            for j = 1:size(px,2)
                if(prev == 0)
                    mask = mask + imtranslate(draw_rectangle(xx, yy, w, w, sg), [px(i), px(j)], "bilinear");
                    prev = 1;
                    else; prev = 0;
                end
            end
        end
    elseif(col == 2)
        px = linspace(-N/2-0.5, N/2-0.5, 9);
        py = linspace(-N/2-0.5, N/2-0.5, 6);
        mask = zeros(size(xx));
        prev = 0; 
        for i = 1:size(py, 2)
            for j = 1:size(px,2)
                if(prev == 0)
                    mask = mask + imtranslate(draw_Ngon(xx, yy, 3, sz, sg), [px(j), py(i)], "bilinear");
                    prev = 1;
                    else; prev = 0;
                end
            end
        end
        mask(mask>1) = mask(mask>1)/2;
    else
        px = linspace(-N/2-0.5+w/2, N/2-0.5, 14);
        py = linspace(-N/2-0.5, N/2-0.5, 8);
        mask = zeros(size(xx));
        prev = 0;
        for i = 1:size(py, 2)
            for j = 1:size(px,2)
                if(prev == 0)
                    mask = mask + imtranslate(draw_Ngon(xx, yy, 8, sz-1, sg), [px(j), py(i)], "bilinear");
                    prev = 1;
                    else; prev = 0;
                end
            end
        end
    end
    if(row == 3)
        obj = mask;
        return
    end
    if(row == 2)
         px1 = -N/2+spacing2/2:spacing2:N/2-1;
    else
        px1 = -N/2+spacing/2:spacing:N/2-1;
    end
    [px, py] = meshgrid(px1, px1);
    obj = zeros(size(xx));
    for i = 1:size(px,1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i,j), py(i,j)], 'bilinear');
        end
    end
    
    if(row == 4)
        obj = obj .* mask;
    end
end