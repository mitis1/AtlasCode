function obj = plate34_obj(row, col, N, sg)
    sz = 80;
    r = 40;

    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x,x);
    if (row == 1 && col == 1)
        obj1 = draw_rectangle(xx, yy, sz*2, sz*2, sg);
        obj2 = draw_rectangle(xx, yy, sz, sz, sg);
        obj1 = (-1*obj1)+1;
        obj = obj1 + obj2;
        obj = -1*obj + 1;
    elseif (row == 1 && col == 2)
        obj1 = draw_circle(xx, yy, r*2, sg);
        obj2 = draw_circle(xx, yy, r, sg);
        obj1 = (-1*obj1)+1;
        obj = obj1 + obj2;
        obj = -1*obj + 1;
    elseif(row == 1 && col == 3)
        obj = draw_Ngon(xx, yy, 3, sz, sg);
    elseif(row == 2 && col == 1)
        obj1 = draw_rectangle(xx, yy, sz*2, sz*2, sg);
        obj2 = draw_circle(xx, yy, r, sg);
        obj1 = (-1*obj1)+1;
        obj = obj1 + obj2;
        obj = -1*obj + 1;
    elseif(row == 2 && col == 2)
        obj = draw_Ngon(xx, yy, 5, sz, sg);
    elseif(row == 2 && col == 3)
        obj = draw_Ngon(xx, yy, 6, sz, sg);
    elseif(row == 3 && col == 1)
        obj = draw_Ngon(xx, yy, 7, sz, sg);
    elseif(row == 3 && col == 2)
        obj = draw_Ngon(xx, yy, 8, sz, sg);
    elseif(row == 3 && col == 3)
        rr = sqrt( xx.^2 + yy.^2 );
        obj = ones(size(xx));
        angles = [0, 60, 180, 180+60];
        for ind = 1:length(angles)
    
            yy_rot = imrotate( yy, angles(ind), 'bilinear','crop');
            im_yy = erfc( ((yy_rot)-sz/2)/sg ) / 2 ;
            obj = obj.*im_yy;
        end
    
        obj( rr> sz ) = 0;
    elseif(row == 4 && col == 1)
        rr = sqrt( xx.^2 + yy.^2 );
        obj = ones(size(xx));
        angles = [0, 72, 180, 288];
        for ind = 1:length(angles)
        
            yy_rot = imrotate( yy, angles(ind), 'bilinear','crop');
            im_yy = erfc( ((yy_rot)-sz/2)/sg ) / 2 ;
            obj = obj.*im_yy;
        end
        
        obj( rr> sz ) = 0;
    elseif(row == 4 && col == 2)
        rr = sqrt( (xx).^2+ (yy).^2*2 );
        obj = erfc( (rr-r)/sg ) / 2;
    elseif(row == 4 && col == 3)
        obj = draw_rectangle(xx, yy, sz, sz, sg);
    end
end