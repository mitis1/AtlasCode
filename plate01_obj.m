function obj = plate01_obj( row, col, N, sg )
    x = (-N/2):(N/2-1);
    [xx, yy] = meshgrid(x, x);

    if col == 1
        pos = [0, 0];
    elseif col == 2
        pos = [ 45, 0;...
               -45, 0];
    elseif col == 3
        pos = [ 200, 0;...
               -200, 0];
    end

    if row == 1
        r = 20;
        shape_func = @() draw_circle(xx, yy, r, sg); 
    elseif row == 2
        r = 40;
        shape_func = @() draw_circle(xx, yy, r, sg); 
    elseif row == 3
        r = 60;
        shape_func = @() draw_circle(xx, yy, r, sg); 
    elseif row == 4
        w = 80; h = 160;
        shape_func = @() draw_rectangle(xx, yy, w, h, sg); 
    end

    obj = zeros( [N, N] );

    for ind_pos = 1:size( pos,1 )
        cur_x = pos(ind_pos,1);
        cur_y = pos(ind_pos,2);

        obj = obj + imtranslate( shape_func(), [cur_x, cur_y], 'bilinear');
    end

    obj( obj> 1 ) = 1;


end