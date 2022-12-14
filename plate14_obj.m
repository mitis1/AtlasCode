function obj = plate14_obj(row, col, N, sg)
    r1 = 15;
    r2 = 18;
    r3 = 20;
    r_outer = 250;
    r_inner = 150;
    r = 5;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    circle_funct = @() draw_circle(xx, yy, r, sg);
    px=[];
    py = [];
    if(row == 1 && col == 1)
        px = r_outer .* cosd( (0:(360/r1):(360-360/r1)) - 90);
        py = r_outer .* sind( (0:(360/r1):(360-360/r1)) - 90);
    elseif(row == 1 && col == 2)
        px = r_outer .* cosd( (0:(360/r2):(360-360/r2)) - 90);
        py = r_outer .* sind( (0:(360/r2):(360-360/r2)) - 90);
    elseif(row == 1 && col == 3)
        px = r_outer .* cosd( (0:(360/r3):(360-360/r3)) - 90);
        py = r_outer .* sind( (0:(360/r3):(360-360/r3)) - 90);
    elseif(row == 2 && col == 1)
        radius = linspace(r_outer, r_inner,4);
        px1 = radius(1) .* cosd( (0:(360/r1):(360-360/r1)) - 90);
        px2 = radius(2) .* cosd( (0:(360/r1):(360-360/r1)) - 90);
        py1 = radius(1) .* sind( (0:(360/r1):(360-360/r1)) - 90);
        py2 = radius(2) .* sind( (0:(360/r1):(360-360/r1)) - 90);
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 2 && col == 2)
        radius = linspace(r_outer, r_inner,4);
        px1 = radius(2) .* cosd( (0:(360/r1):(360-360/r1)) - 90);
        py1 = radius(2) .* sind( (0:(360/r1):(360-360/r1)) - 90);
        px2 = radius(1) .* cosd( (0:(360/r2):(360-360/r2)) - 90);
        py2 = radius(1) .* sind( (0:(360/r2):(360-360/r2)) - 90);
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 2 && col == 3)
        radius = linspace(r_outer, r_inner,4);
        px1 = radius(2) .* cosd( (0:(360/r1):(360-360/r1)) - 90);
        py1 = radius(2) .* sind( (0:(360/r1):(360-360/r1)) - 90);
        px2 = radius(1) .* cosd( (0:(360/r3):(360-360/r3)) - 90);
        py2 = radius(1) .* sind( (0:(360/r3):(360-360/r3)) - 90);
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 3 && col == 1)
        radius = linspace(r_outer, r_inner, 4);
        for i = 1:size(radius, 2)
            px = [px, radius(i) .* cosd( (0:(360/r1):(360-360/r1)) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r1):(360-360/r1)) - 90)];
        end
    elseif(row == 3 && col == 2)
        ring_radii = linspace(r_inner, r_outer,4);
        num_rings = length(ring_radii);
        
        num_points = r3;
        theta_offset = pi/25;
        
%         figure
%         hold on
        for ind_ring = 1:num_rings
            thetas = linspace(0,2*pi, num_points+1);
            thetas(end) = [];
            thetas = thetas + ind_ring*theta_offset;
            px = [px, ring_radii(ind_ring)*cos(thetas)];
            py = [py, ring_radii(ind_ring)*sin(thetas)];
        end
    elseif(row == 3 && col == 3)
        radius = linspace(r_outer, r_inner,4);
        r_val = [20, 18, 15, 12];
        for i = 1:length(radius)
            px = [px, radius(i) .* cosd( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
        end
    elseif(row == 4 && col == 1)
        num_points = 15;
        r_val = linspace(r_outer, r_inner,4);
        thetas = linspace( 0, 2*pi, num_points);
        radius = linspace( r_val(1), r_val(2), num_points);
        
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    elseif(row == 4 && col == 2)
        num_points = 19;
        r_val = linspace(r_outer, r_inner,4);
        thetas = linspace( 0, 2*pi, num_points);
        radius = linspace( r_val(1), r_val(2), num_points);
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    elseif(row == 4 && col == 3)
        num_points = 49;
        r_val = linspace(r_outer, r_inner,4);
        thetas = linspace( 0, 8*pi, num_points);
        radius = linspace( r_val(1), r_val(4), num_points);
        
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    end
    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
    end
    if(row == 4); obj = imrotate(obj, 90, 'bilinear', 'crop'); end
end