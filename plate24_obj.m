function obj = plate24_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 3;
w = 1;
h = 3;
a = 3.6;
if(row == 2 || row == 4)
    obj_funct = @() draw_circle(xx, yy, r, sg);
else
    obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
end

r0 = 30;
r1 = 10;
w0 = 0.75;
w1 = 10;
p0 = 50;
alpha = atan((2*pi*r0)/p0);
t_min = -(8)*pi;
t_max = (8)*pi;
t_step1 = 0.01;
t_step2 = 0.05;
rot_x_val = -45;
rot_z_val = -45;
add_val = 10;
if(row == 1 && col == 1)
    t = t_min:t_step1:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
        
    val = y_rot*z_rot*x_rot * [x;y;z];
    
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 1 && col == 2)
    w1 = w1 + add_val;
    t = t_min:t_step1:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 1 && col == 3)
    w1 = w1 + add_val*2;
    t = t_min:t_step1:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 2 && col == 1)
    t = t_min:t_step2:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 2 && col == 2)
    w1 = w1 + add_val;
    t = t_min:t_step2:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 2 && col == 3)
    w1 = w1 + add_val*2;
    t = t_min:t_step2:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 3 && col == 1)
    w1 = w1-add_val/2;
    t = t_min:t_step1:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_x_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 3 && col == 2)
    px = -N/2:0.75:N/2-1;
    py1 = 50*sind(5*px);
    py2 = 50*sind(5*(px+180));
    px = [px,px];
    py = [py1,py2];
elseif(row == 3 && col == 3)
    px = -N/2:0.75:N/2-1;
    py1 = 50*sind(5*px);
    py2 = 50*sind(5*(px+45));
    px = [px,px];
    py = [py1,py2];
elseif(row == 4 && col == 1)
    w1 = w1 - add_val/2;
    t = t_min:t_step2:t_max;
    x = r0.*cos(w0.*t)+r1.*cos(w0.*t).*cos(w1*t)-r1.*cos(alpha).*sin(w0*t).*sin(w1.*t);
    y = r0.*sin(w0.*t)+r1.*sin(w0.*t).*cos(w1*t)+r1.*cos(alpha).*cos(w0*t).*sin(w1.*t);
    z = p0.*w0.*t-r1.*sin(alpha).*sin(w0.*t);
    
    x_rot = rotx(rot_z_val);
    y_rot = roty(0);
    z_rot = rotz(rot_z_val);
    val = y_rot*z_rot*x_rot * [x;y;z];
    px = val(1,:);
    y = val(2,:);
    py = val(3,:);
elseif(row == 4 && col == 2)
    px = -N/2:2:N/2-1;
    py1 = 50*sind(5*px);
    py2 = 50*sind(5*(px+180));
    px = [px,px];
    py = [py1,py2];
elseif(row == 4 && col == 3)
    px = -N/2:2:N/2-1;
    py1 = 50*sind(5*px);
    py2 = 50*sind(5*(px+45));
    px = [px,px];
    py = [py1,py2];
end
if(~(row == 4 && col == 2) && ~(row == 3 && col == 2) && ...
        ~(row == 4 && col == 3) && ~(row == 4 && col == 2))
    px = px;
    py = py;
end
for i = 1:size(px,2)
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
    obj(obj>1) = obj(obj>1)/2;
end

if(~(row == 4 && col == 2) && ~(row == 3 && col == 2) && ...
        ~(row == 4 && col == 3) && ~(row == 4 && col == 2))
    obj = imrotate(obj, 55, 'bilinear', 'crop');
end
if(row == 3 && col == 3)
    obj = imrotate(obj, -55, 'bilinear', 'crop');
end
end