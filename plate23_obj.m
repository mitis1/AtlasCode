function obj = plate23_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 3;
w = 1;
h = 3;
a = 3.6;
r_helix = 50;
if(col == 1)
    obj_funct = @() draw_circle(xx, yy, r, sg);
else
    obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
end

if(row == 1 && col == 1)
    px = -N/2:N/2-1;
    py = 50*sind(5*px);
    
    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
    return
elseif(row == 1 && col == 2)
    px = -N/2:3:N/2-1;
    py = 50*sind(5*px);
    
    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
    return
elseif(row == 1 && col == 3)
    px = -N/2:5:N/2-1;
    py = 50*sind(5*px);
    
    obj = zeros(size(xx));
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
    return
% elseif(row == 2 && col == 1)
%     px = -N/2:N/2-1;
%     py = 50*sind(2*px);
%     
%     obj = zeros(size(xx));
%     for i = 1:size(px,2)
%         obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
%         obj(obj>1) = obj(obj>1)/2;
%     end
%     return
% elseif(row == 2 && col == 2)
%     px = -N/2:3:N/2-1;
%     py = 50*sind(2*px);
%     
%     obj = zeros(size(xx));
%     for i = 1:size(px,2)
%         obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
%         obj(obj>1) = obj(obj>1)/2;
%     end
%     return
% elseif(row == 2 && col == 3)
%     px = -N/2:5:N/2-1;
%     py = 50*sind(2*px);
%     
%     obj = zeros(size(xx));
%     for i = 1:size(px,2)
%         obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
%         obj(obj>1) = obj(obj>1)/2;
%     end
%     return




elseif(row == 2 && col == 1)
    t = -250:1:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(82);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 2 && col == 2)
    t = -250:2:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(82);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 2 && col == 3)
    t = -250:3:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(82);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end





elseif(row == 3 && col == 1)
    t = -250:1:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(50);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 3 && col == 2)
    t = -250:2:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(50);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 3 && col == 3)
    t = -250:3:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(50);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 1)
    t = -250:1:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(75);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 2)
    t = -250:2:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(75);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end
elseif(row == 4 && col == 3)
    t = -250:3:250;
    px = r_helix*cosd(a*t);
    py = r_helix*sind(a*t);
    z = a*t;
    x_rot = rotx(75);
    
    val = x_rot * [px;py;z];
    
    px = val(1,:);
    py = val(2,:);
    z = val(3,:);
    for i = 1:size(px,2)
        obj = obj + imtranslate(obj_funct(), [z(i), px(i)], 'bilinear');
        obj(obj>1) = obj(obj>1)/2;
    end

end
end