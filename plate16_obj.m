function obj = plate16_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r_circle = 10;
r_hex = 35;
sz = 7;
spacing = 30;

if(row == 1 && col == 1)
    obj_funct = @( ) draw_circle(xx, yy, r_circle, sg);
    num_pts = randi(20) + 120;
elseif(col == 2)
    obj_funct = @(theta, phi) draw_hex(xx, yy, r_hex, r_circle, theta, phi, sg);
    num_pts = randi(5) + 75;
elseif(col == 3)
    obj_funct = @(theta, phi) draw_crystal(xx, yy, sz, spacing, r_circle, theta, phi, sg);
    num_pts = randi(2) + 14;
elseif(col == 1)
    obj_funct = @(theta, phi) draw_pair(xx, yy, spacing, r_circle, theta, phi, sg);
    num_pts = randi(10) + 100;
end
obj = zeros(size(xx));
px = -1*N/2 + (N)*rand(1, num_pts);
py = -1*N/2 + (N)*rand(1, num_pts); 
if(row == 1 && col == 1)
    for i = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 1 && col == 2)
    for i = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 1 && col == 3)
    for i = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 2 && col == 1)
    for i = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 2 && col == 2)
    phi = 360*rand(1,num_pts);
    for i = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(0,phi(i)), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 2 && col == 3)
    ang = 360*rand(1, num_pts);
    for i = 1:size(px, 2)
        obj = obj + imrotate(imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear'), ang(i), 'bilinear', 'crop');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 3 && col == 1)
    ang = 360*rand(1, num_pts);
    for i = 1:size(px, 2)
        obj = obj + imrotate(imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear'), ang(i), 'bilinear', 'crop');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 3 && col == 2)
    ang = 360*rand(1, num_pts);
    for i = 1:size(px, 2)
        obj = obj + imrotate(imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear'), ang(i), 'bilinear', 'crop');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 3 && col == 3)
    for i = 1:size(px, 2)
        ang = normrnd(0, 0.3);
        obj = obj + imrotate(imtranslate(obj_funct(0,0), [px(i), py(i)], 'bilinear'), 360*ang, 'bilinear', 'crop');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 1) 
    for i = 1:size(px, 2)
        phi = 360*rand(1,1);
        theta = 360*rand(1,1);
        obj = obj + imtranslate(obj_funct(theta,phi), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 2)
    for i = 1:size(px, 2)
        phi = 360*rand(1,1);
        theta = 360*rand(1,1);
        obj = obj + imtranslate(obj_funct(theta,phi), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 3)
    for i = 1:size(px, 2)
        phi = 360*rand(1,1);
        theta = 360*rand(1,1);
        obj = obj + imtranslate(obj_funct(theta,phi), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
end
end