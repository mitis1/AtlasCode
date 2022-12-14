function obj = plate07_obj(row, col, N, sg)
    r = 15;
    r_oct1 = 100;
    r_oct2 = 150;
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    circle_funct = @( ) draw_circle(xx, yy, r, sg);
    if (row == 1 && col == 1)
        theta_offset = 0;
        phi_offset = 0;
    elseif(row == 1 && col == 2)
        theta_offset = 45;
        phi_offset = 45;
    elseif(row == 1 && col == 3)
        theta_offset = -45;
        phi_offset = 45;
    elseif(row == 2 && col == 1)
        theta_offset = 80;
        phi_offset = 0;
    elseif(row == 2 && col == 2)
        theta_offset = 0;
        phi_offset = 80;
    elseif(row == 2 && col == 3)
        theta_offset = 45;
        phi_offset = 10;
    elseif(row == 3 && col == 1)
        theta_offset = 45;
        phi_offset = 45;
    elseif(row == 3 && col == 2)
        theta_offset = -45;
        phi_offset = 45;
    elseif(row == 3 && col == 3)
        theta_offset = 80;
        phi_offset = 0;
    elseif(row == 4 && col == 1)
        theta_offset = 0;
        phi_offset = 80;
    elseif(row == 4 && col == 2)
        theta_offset = 45;
        phi_offset = 10;
    elseif(row == 4 && col == 3)
        theta_offset = 90;
        phi_offset = 90;
    end
    R_phi = [1, 0, 0 ; 
             0, cosd(phi_offset), sind(phi_offset);
             0, -sind(phi_offset), cosd(phi_offset)];
    R_theta = [cosd(theta_offset), 0, sind(theta_offset);
                0, 1, 0
                sind(theta_offset), 0, cosd(theta_offset)];
    shift = (360/16);
    px = r_oct1 .* cosd(0:45:315);
    py = r_oct1 .* sind(0:45:315);
    px1 = r_oct2 .* cosd(0:45:315);
    py1 = r_oct2 .* sind(0:45:315);
    px1(7) = []; px1(3) = [];
    py1(7) = []; py1(3) = [];
    px = [px, px1];
    py = [py, py1];
    z = zeros(size(px));
    if(row == 1 || row == 2)
        val = R_theta * (R_phi * [px; py; z]);
    else
        val = R_phi * (R_theta * [px; py; z]);
    end
    px = val(1,:);
    py = val(2,:);
    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj  = obj + imtranslate(circle_funct(), [px(i), py(i)], "bilinear");
    end
end