function obj = plate02_obj(row,col, N, sg)
    r_hex = 80;
    r = 25;
    if(row == 1 && col == 1)
        rm_pts = [1,2,3,5,6];
    elseif(row == 1 && col == 2)
        rm_pts = [1,2,5,6];
    elseif(row == 1 && col == 3)
        rm_pts = [2,3,5,6];
    elseif(row == 2 && col == 1)
        rm_pts = [1,3,5,6];
    elseif(row == 2 && col == 2)
        rm_pts = [1,5,6];
    elseif(row == 2 && col == 3)
        rm_pts = [2,5,6];
    elseif(row == 3 && col == 1)
        rm_pts = [1,3,5];
    elseif(row == 3 && col == 2)
        rm_pts = [1,6];
    elseif(row == 3 && col == 3)
        rm_pts = [2,5];
    elseif(row == 4 && col == 1)
        rm_pts = [1,3];
    elseif(row == 4 && col == 2)
        rm_pts = [1];
    elseif(row == 4 && col == 3)
        rm_pts = [];
    end
    x = (-N/2):(N/2-1);
    [xx,yy] = meshgrid( x, x );
    circle_funct = @( ) draw_circle(xx, yy, r, sg);
    
    px1 = r_hex*cosd( (0:60:300) + 30 );
    py1 = r_hex*sind( (0:60:300) + 30 );
    
    obj = zeros( size(xx) );
    
    % variable radius
    count = 1;
    for i = 1:size(px1, 2)
        if(count <= size(rm_pts, 2) && rm_pts(count) == i)
            count = count + 1;
            continue;
        end
        obj = obj+imtranslate( circle_funct(), [px1(i), py1(i)], 'bilinear');
    end
end