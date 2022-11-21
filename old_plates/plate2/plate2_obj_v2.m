function obj = plate2_obj_v2(N, r_hex, r, rm_pts, sg)
    % create circle with erf so soft boundry    
    x = (-N/2):(N/2-1);
    [xx,yy] = meshgrid( x, x );
    circle = @(x0,y0) (sqrt((xx-x0).^2+(yy-y0).^2)-r);
    
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
        obj = obj+circle(px1(i), py1(i));
    end
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
end