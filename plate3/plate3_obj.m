function obj = plate3_obj(N, r_circle, r_oct1, r_oct2, sg, rm_pts)

    % create circle with erf so soft boundry    
    x = (-N/2):(N/2-1);
    [xx,yy] = meshgrid( x, x );
    circle = @(x0,y0, r, sg) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;

    
    px1 = r_oct1*cosd( (0:60:300)' + 30 );
    py1 = r_oct1*sind( (0:60:300)' + 30 );
    px2 = r_oct2*cosd( (0:60:300)' + 30 );
    py2 = r_oct2*sind( (0:60:300)' + 30 );
    
    obj = zeros( size(xx) );

    % constant radius
    % points = [px1, py1; px2, py2];
    % num_points = size(points,1);
    % for ind_point = 1:num_points
    %     cur_x = points(ind_point,1);
    %     cur_y = points(ind_point,2);
    %     obj = obj + circle( cur_x,cur_y, r_circle, 10);
    % end

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