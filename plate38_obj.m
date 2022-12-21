function obj = plate38_obj(row, col, N, sg)
    r1 = 15;
    r2 = 18;
    r3 = 20;
    r_outer = 250;
    r_inner = 150;
    r = 5;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    circle_funct = @() draw_circle(xx, yy, r, sg);
    if(row == 3)
        circle_funct = @() draw_circle(xx, yy, r*2, sg);
    end
    px=[];
    py = [];
    if(row == 1 && col == 1)
        radius = linspace(r_outer, 0, 8);
        for i = 1:size(radius, 2)
            px = [px, radius(i) .* cosd( (0:(360/r1):(360-360/r1)) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r1):(360-360/r1)) - 90)];
        end
    elseif(row == 1 && col == 2)
        ring_radii = linspace(0, r_outer,8);
        num_rings = length(ring_radii);
        
        num_points = r3;
        theta_offset = pi/25;
        for ind_ring = 1:num_rings
            thetas = linspace(0,2*pi, num_points+1);
            thetas(end) = [];
            thetas = thetas + ind_ring*theta_offset;
            px = [px, ring_radii(ind_ring)*cos(thetas)];
            py = [py, ring_radii(ind_ring)*sin(thetas)];
        end
    elseif(row == 1 && col == 3)
        radius = linspace(r_outer, 0,8);
        r_val = [20, 18, 15, 12, 9, 6, 3, 0];
        for i = 1:length(radius)
            px = [px, radius(i) .* cosd( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
        end
    elseif(row == 2 && col == 1)
        num_points = 79;
%         r_val = linspace(r_outer, 0,8);
        thetas = linspace( 0, 32*pi, num_points);
        radius = linspace( r_outer, 0, num_points);
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    elseif(row == 2 && col == 2)
        ring_radii = linspace(0, r_outer,12);
        num_rings = length(ring_radii);
        
        num_points = r3;
        theta_offset = pi/25;
        for ind_ring = 1:num_rings
            thetas = linspace(0,2*pi, num_points+1);
            thetas(end) = [];
            thetas = thetas + ind_ring*theta_offset;
            px = [px, ring_radii(ind_ring)*cos(thetas)];
            py = [py, ring_radii(ind_ring)*sin(thetas)];
        end
    elseif(row == 2 && col == 3)
%         ring_radii = linspace(0, r_outer,4);
%         num_rings = length(ring_radii);
%         
%         num_points = r3;
%         theta_offset = pi/25;
%         for ind_ring = 1:num_rings
%             thetas = linspace(0,2*pi, num_points+1);
%             thetas(end) = [];
%             thetas = thetas + ind_ring*theta_offset;
%             px = [px, ring_radii(ind_ring)*cos(thetas)];
%             py = [py, ring_radii(ind_ring)*sin(thetas)];
%         end
        num_points = 79;
%         r_val = linspace(r_outer, 0,8);
        thetas = linspace( 0, 64*pi, num_points);
        radius = linspace( r_outer, 0, num_points);
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);   
        
    elseif(row == 3 && col == 1)
        radius = linspace(r_outer, 0, 8);
        for i = 1:size(radius, 2)
            px = [px, radius(i) .* cosd( (0:(360/r1):(360-360/r1)) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r1):(360-360/r1)) - 90)];
        end
    elseif(row == 3 && col == 2)
        radius = linspace(r_outer, 0,8);
        r_val = [20, 18, 15, 12, 9, 6, 3, 0];
        for i = 1:length(radius)
            px = [px, radius(i) .* cosd( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
        end
    elseif(row == 3 && col == 3)
        num_points = 79;
        r_val = linspace(r_outer, 0,8);
        thetas = linspace( 0, 32*pi, num_points);
        radius = linspace( r_val(1), r_val(2), num_points);
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    elseif(row == 4 && col == 1)
        radius = linspace(r_outer, 0, 12);
        for i = 1:size(radius, 2)
            px = [px, radius(i) .* cosd( (0:(360/r3):(360-360/r3)) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r3):(360-360/r3)) - 90)];
        end
    elseif(row == 4 && col == 2)
        radius = linspace(r_outer, 0,12);
        r_val = [36, 33, 30, 27, 24, 21, 18, 15, 12, 9, 6, 3];
        for i = 1:length(radius)
            px = [px, radius(i) .* cosd( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
            py = [py, radius(i) .* sind( (0:(360/r_val(i)):(360-360/r_val(i))) - 90)];
        end
    elseif(row == 4 && col == 3)
        num_points = 59;
%         r_val = linspace(r_outer, 0,8);
        thetas = linspace( 0, 32*pi, num_points);
        radius = linspace( r_outer, 0, num_points);
        px = radius.*cos(thetas);
        py = radius.*sin(thetas);
    end


    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
    end
    if(row == 4); obj = imrotate(obj, 90, 'bilinear', 'crop'); end
end