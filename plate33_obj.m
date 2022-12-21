function obj = plate33_obj(row,col, N, sg)
        sz = 80;
        r = 40;

    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x,x);
    if (row == 1 && col == 1)
        obj = draw_circle(xx, yy, r, sg);
        im_yy = erfc( ((yy)/2)/sg ) / 2 ;
        obj = obj .* im_yy;
    elseif (row == 1 && col == 2)
        obj = draw_circle(xx, yy, r, sg);
        im_yy = erfc( ((-yy)/2)/sg ) / 2 ;
        obj = obj .* im_yy;
    elseif(row == 1 && col == 3)
        obj = draw_circle(xx, yy, r, sg);
    elseif(row == 2 && col == 1)
        obj = draw_Ngon(xx, yy, 3, sz, sg);
    elseif(row == 2 && col == 2)
        obj = draw_Ngon(xx, -yy, 3, sz, sg);
    elseif(row == 2 && col == 3)
        obj1 = draw_Ngon(xx, yy, 3, sz, 0);
        obj2 = draw_Ngon(xx, -yy, 3, sz, 0);
        obj = obj1 + obj2;
        obj(obj > 1) = obj(obj > 1)/2;
        obj(isnan(obj)) = 1;
        obj = imgaussfilt(obj, sg, "FilterDomain", "frequency");
    elseif(row == 3 && col == 1)
        obj1 = draw_rectangle(xx, yy, sz, sz, sg);
        obj = imtranslate(obj1, [sz, 0], 'bilinear');
    elseif(row == 3 && col == 2)
        obj1 = draw_rectangle(xx, yy, sz, sz, sg);
        obj = imtranslate(obj1, [-sz, 0], 'bilinear');
    elseif(row == 3 && col == 3)
        obj = draw_rectangle(xx, yy, sz*2, sz, sg);
    elseif(row == 4 && col == 1)
        obj = draw_circle(xx, yy, r/2, sg);
    elseif(row == 4 && col == 2)
        obj = draw_circle(xx, yy, r, sg);
    elseif(row == 4 && col == 3)
        obj = draw_circle(xx, yy, r*2, sg);
    end
end