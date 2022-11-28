function obj = plate34_obj(row,col, N, sg)
    spacing = 29;
    w = 5;
    h = 10;
    r = 5;
    sz = N/7;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    px1 = -N/2+spacing/2:spacing:N/2-1;
    [px, py] = meshgrid(px1, px1);

    if(col == 1)
        obj_funct = @() draw_circle(xx, yy, r, sg);
    elseif(col == 2)
        obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
    elseif(col == 3)
        obj_funct = @() draw_rectangle(xx, yy, w, w, sg);
    end

    obj = zeros(size(xx));
    for i = 1:size(px,1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i,j), py(i,j)], 'bilinear');
        end
    end

    if(row == 2)
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
    elseif(row == 3)
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
    elseif(row == 4)
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
    elseif(row == 1)
        mask = ones(size(xx));
    end

    obj = obj .* mask;
end