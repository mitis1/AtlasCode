function obj = phase6_obj(N,row, col, r_hex, r, sg)
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    circle = @(x0,y0) -(erf((sqrt((xx-x0).^2+(yy-y0).^2)-r)/sg)-1)/2;
    if(col == 1)
        px = r_hex*cosd( (0:60:300) );
        py = r_hex*sind( (0:60:300) );
    elseif(col == 2)
        px1 = r_hex*cosd( (0:60:300) );
        py1 = r_hex*sind( (0:60:300) );
        px2 = r_hex*cosd( (0:60:300) ) + (2*r_hex-20)*cosd(90);
        py2 = r_hex*sind( (0:60:300) ) + (2*r_hex-20)*sind(90);
        px3 = r_hex*cosd( (0:60:300) ) + (2*r_hex-20)*cosd(270);
        py3 = r_hex*sind( (0:60:300) ) + (2*r_hex-20)*sind(270);
        px = [px1, px2, px3];
        py = [py1, py2, py3];
    elseif(col == 3)
        px1 = r_hex*cosd( (0:60:300) );
        py1 = r_hex*sind( (0:60:300) );
        px2 = r_hex*cosd( (0:60:300) ) + (2*r_hex-20)*cosd(330);
        py2 = r_hex*sind( (0:60:300) ) + (2*r_hex-20)*sind(330);
        px3 = r_hex*cosd( (0:60:300) ) + (2*r_hex-20)*cosd(150);
        py3 = r_hex*sind( (0:60:300) ) + (2*r_hex-20)*sind(150);
        px = [px1, px2, px3];
        py = [py1, py2, py3];
    end
    if(row == 2)
        px = px .* 0.6;
    elseif(row == 3)
        py = py .* 0.6;
    elseif(row == 4)
        px = px .* 0.4;
        if(col == 1 || col == 2)
            theta = 10;
            R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
            coords = [px; py];
            new_coords = R * coords;
            px = new_coords(1, :);
            py = new_coords(2, :);
        end
%         py = py .* 0.6;
    end
    obj = zeros([N N]);
    for i = 1:size(px, 2)
        obj = obj + circle(px(i), py(i));
    end
    obj(obj > 1) = obj(obj>1)/2;
return