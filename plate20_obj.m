function obj = plate20_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x,x);
r = 2;
spacing = 14;
obj_funct = @() draw_circle(xx, yy, r, sg);
x1 = -N/2:spacing:N/2+1;
[px, py] = meshgrid(x1, x1);
mult = (2*pi)/10;
t = -N/2:N/2-1;
% R = [ cos(theta), -sin(theta);
%     sin(theta), cos(theta)];
rand_val = 2*pi*rand(1,1);
theta_val = 2*pi*rand(1,2);
if(row == 1 && col == 1)
elseif(row == 1 && col == 2)
    disp_x = sin(mult*t)*spacing/4;
    for i = 1:size(py, 1)
        py(i,:) = py(i,:) + disp_x(i);
    end
elseif(row == 1 && col == 3)
    disp_x = sin(mult*t)*spacing/2;
    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + disp_x(i);
    end
elseif(row == 2 && col == 1)
    disp_x = sin(mult*t)*spacing/4;
    disp_y = zeros(size(disp_x));
    rot_mat = [ cos(rand_val), -sin(rand_val);
    sin(rand_val), cos(rand_val)];
    res = rot_mat * [disp_x; disp_y];
    disp_x = res(1,:);
    disp_y = res(2,:);
    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + disp_x(i);
    end
    for i = 1:size(py, 2)
        py(:,i) = py(:,i) + disp_y(i);
    end
elseif(row == 2 && col == 2)
    disp_x = sin(mult*t)*spacing*(1/2);
    disp_y = zeros(size(disp_x));
    rot_mat = [ cos(rand_val), -sin(rand_val);
    sin(rand_val), cos(rand_val)];
    res = rot_mat * [disp_x; disp_y];
    disp_x = res(1,:);
    disp_y = res(2,:);
    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + disp_x(i);
    end
    for i = 1:size(py, 2)
        py(:,i) = py(:,i) + disp_y(i);
    end
elseif(row == 2 && col == 3)
    mult = (2*pi)/(N/5);
    disp_x = sin(mult*t)*spacing*(1/4);
    disp_y = zeros(size(disp_x));
    rot_mat = [ cos(rand_val), -sin(rand_val);
    sin(rand_val), cos(rand_val)];
    res = rot_mat * [disp_x; disp_y];
    disp_x = res(1,:);
    disp_y = res(2,:);
    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + disp_x(i);
    end
    for i = 1:size(py, 2)
        py(:,i) = py(:,i) + disp_y(i);
    end
elseif(row == 3 && col == 1)
    disp_x = sin(mult*t)*spacing/4;
    disp_y = zeros(size(disp_x));
    rot_mat = [ cos(rand_val), -sin(rand_val);
    sin(rand_val), cos(rand_val)];
    res = rot_mat * [disp_x; disp_y];
    disp_x = res(1,:);
    disp_y = res(2,:);
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) + disp_x(i);
    end
    for i = 1:size(py, 1)
        py(i,:) = py(i,:) + disp_y(i);
    end
elseif(row == 3 && col == 2)
    disp_x = sin(mult*t)*spacing/4;
    disp_y = zeros(size(disp_x));
    rot_mat = [ cos(rand_val), -sin(rand_val);
    sin(rand_val), cos(rand_val)];
    res = rot_mat * [disp_x; disp_y];

    theta_rot = 2*pi*rand(1,1);
    disp_x = res(1,:);
    disp_y = res(2,:);
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) + cos(theta_rot)*disp_x(i);
    end
    for i = 1:size(py, 1)
        py(i,:) = py(i,:) + cos(theta_rot)*disp_y(i);
    end

    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + sin(theta_rot)*disp_x(i);
    end
    for i = 1:size(py, 2)
        py(:,i) = py(:,i) + sin(theta_rot)*disp_y(i);
    end
elseif(row == 3 && col == 3)
    disp_x1 = sin(mult*t)*spacing/4;
    disp_y1 = zeros(size(disp_x1));
    disp_x2 = sin(mult*t)*spacing/2;
    disp_y2 = zeros(size(disp_x2));
    
    rot_mat = [ cos(theta_val(1)), -sin(theta_val(1));
    sin(theta_val(1)), cos(theta_val(1))];
    res1 = rot_mat * [disp_x1; disp_y1];
    disp_x1 = res1(1,:);
    disp_y1 = res1(2,:);
    rot_mat = [ cos(theta_val(2)), -sin(theta_val(2));
    sin(theta_val(2)), cos(theta_val(2))];
    res2 = rot_mat * [disp_x2; disp_y2];
    disp_x2 = res2(1,:);
    disp_y2 = res2(2,:);

    theta_rot = 2*pi*rand(1,1);
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) + cos(theta_rot)*disp_x1(i)+cos(theta_rot)*disp_x2(i);
    end
    for i = 1:size(py, 1)
        py(i,:) = py(i,:) + cos(theta_rot)*disp_y1(i)+cos(theta_rot)*disp_y2(i);
    end

    for i = 1:size(px, 1)
        px(i, :) = px(i,:) + sin(theta_rot)*disp_x2(i)+sin(theta_rot)*disp_x2(i);
    end
    for i = 1:size(py, 2)
        py(:,i) = py(:,i) + sin(theta_rot)*disp_y1(i)+sin(theta_rot)*disp_y2(i);
    end
elseif(row == 4 && col == 1)
    disp_x1 = sin(mult*t)*spacing/4;
    disp_y1 = zeros(size(disp_x1));
    disp_x2 = sin(mult*t)*spacing/2;
    disp_y2 = zeros(size(disp_x2));
    
    rot_mat = [ cos(theta_val(1)), -sin(theta_val(1));
    sin(theta_val(1)), cos(theta_val(1))];
    res1 = rot_mat * [disp_x1; disp_y1];
    rot_mat = [ cos(theta_val(2)), -sin(theta_val(2));
    sin(theta_val(2)), cos(theta_val(2))];
    res2 = rot_mat * [disp_x2; disp_y2];
    for i = 1:size(px, 2)
        px(i, :) = px(i,:) + res1(1,i)+res2(1,i);
    end
    for i = 1:size(py, 1)
        py(:,i) = py(:,i) + res1(2,i)+res2(2,i);
    end
elseif(row == 4 && col == 2)
    for j = 1:6
        wavelength = 2*pi/10+rand(1,1)*2;
        theta_rot = 2*pi*rand(1,1); 
        phi_rot = 2*pi*rand(1,1);
        disp_x = sin(wavelength*t)*spacing/4;
        disp_y = zeros(size(disp_x));
        rot_mat = [ cos(theta_rot), -sin(theta_rot);
                    sin(theta_rot), cos(theta_rot)];
        res = rot_mat * [disp_x; disp_y];
        disp_x = res(1,:);
        disp_y = res(2,:);
        for i = 1:size(px, 2)
            px(:, i) = px(:,i) + cos(phi_rot)*disp_x(i);
        end
        for i = 1:size(py, 1)
            py(i,:) = py(i,:) + cos(phi_rot)*disp_y(i);
        end
    
        for i = 1:size(px, 1)
            px(i, :) = px(i,:) + sin(phi_rot)*disp_x(i);
        end
        for i = 1:size(py, 2)
            py(:,i) = py(:,i) + sin(phi_rot)*disp_y(i);
        end
    end
elseif(row == 4 && col == 3)
    for j = 1:24
        wavelength = 2*pi/10+rand(1,1)*2;
        theta_rot = 2*pi*rand(1,1); 
        phi_rot = 2*pi*rand(1,1);
        disp_x = sin(wavelength*t)*spacing/4;
        disp_y = zeros(size(disp_x));
        rot_mat = [ cos(theta_rot), -sin(theta_rot);
                    sin(theta_rot), cos(theta_rot)];
        res = rot_mat * [disp_x; disp_y];
        disp_x = res(1,:);
        disp_y = res(2,:);
        for i = 1:size(px, 2)
            px(:, i) = px(:,i) + cos(phi_rot)*disp_x(i);
        end
        for i = 1:size(py, 1)
            py(i,:) = py(i,:) + cos(phi_rot)*disp_y(i);
        end
    
        for i = 1:size(px, 1)
            px(i, :) = px(i,:) + sin(phi_rot)*disp_x(i);
        end
        for i = 1:size(py, 2)
            py(:,i) = py(:,i) + sin(phi_rot)*disp_y(i);
        end
    end
end
obj = zeros(size(xx));
for i = 1:size(px, 1)
    for j = 1:size(px, 2)
        obj = obj + imtranslate(obj_funct(), [px(i,j), py(i,j)], 'bilinear');
    end
end

end