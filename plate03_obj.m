function obj = plate03_obj(row,col, N, sg)
    r_circle = 25;
    r_oct1 = 80;
    r_oct2 = 140;
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
    circle = @(x0,y0, r, sg) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;

    
    px1 = r_oct1*cosd( (0:60:300)' + 30 );
    py1 = r_oct1*sind( (0:60:300)' + 30 );
    px2 = r_oct2*cosd( (0:60:300)' + 30 );
    py2 = r_oct2*sind( (0:60:300)' + 30 );
    
    obj = zeros( size(xx) );
    % variable radius
    count = 1;
    for i = 1:size(px1, 1)
        obj = obj+circle(px1(i), py1(i),r_circle, sg);
        if(count <= size(rm_pts, 2) && rm_pts(count) == i)
            count = count + 1;
            continue;
        end
        obj = obj+circle(px2(i), py2(i),r_circle, sg);
    end
end