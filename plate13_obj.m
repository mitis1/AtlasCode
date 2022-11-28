function obj = plate13_obj(row, col, N, sg)
spacing = 58;
    r = 15;
    w = 10*2;
    h = 20*2;
    r1 = 350;
    r2 = 250;
    r3 = 100;
    angle1 = 15;
    angle2 = 30;
    h1 = 350*2;
    w1 = 150*2;
    h2 = 300*2;
    px1 = -N/2:spacing:N/2-1;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    [px, py] = meshgrid(px1, px1);
    if(row == 1 || row == 2)
        obj_funct = @() draw_circle(xx, yy, r, sg);
    elseif(col == 2 && (row == 3 || row == 4))
        obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
    elseif(row == 3 && col == 1)
        obj_funct = @() draw_rectangle(xx, yy, w, w, sg);
    else
        obj_funct = @() imrotate(draw_rectangle(xx, yy, w, h, sg), angle1, 'bilinear', 'crop');
    end
    
    mask = zeros(size(xx));
    if((row == 1 && col == 1) || row == 3)
        mask = draw_circle(xx, yy, r1, sg);
    elseif(row == 1 && col == 2)
        mask = draw_circle(xx, yy, r2, sg);
    elseif(row == 1 && col == 3)
        mask = draw_circle(xx, yy, r3, sg);
    elseif(row == 2 && col == 1)
        mask = draw_rectangle(xx, yy, h1, h1, sg);
    elseif((row == 2 && col == 2) || (row == 4 && col == 1))
        mask = draw_rectangle(xx, yy, w1, h1, sg);
    elseif((row == 2 && col == 3) || (row == 4 && col == 2))
        mask = imrotate(draw_rectangle(xx, yy, w1, h2, sg), angle2, 'bilinear', 'crop');
    elseif(row == 4 && col == 3)
        rx = r2 * cosd( (0:60:300) ); 
        ry = r2 * sind( (0:60:300) ); 
        mask = zeros(size(xx));
        for i = 1:size(rx,2)
            mask = mask + imtranslate(draw_circle(xx, yy, r3, sg), [rx(i), ry(i)], 'bilinear');
        end
    end
    obj = zeros(size(xx));
    for i = 1:size(px,1)
        for j = 1:size(px, 2)
            obj = obj + imtranslate(obj_funct(), [px(i,j), py(i,j)], 'bilinear');
        end
    end
    obj = obj .* mask;
end