function [x,theta, phi] = gen_pt(triangle_num,curr_point)
    omega = -atan(0.5);
    x = curr_point(1);
    theta = curr_point(2);
    phi = curr_point(3);
    if(triangle_num == 1)
        x = sqrt(5)*rot(omega)*x;
        theta = theta*rot(omega-phi*omega);
        % keep phi the same
    elseif(triangle_num == 2)
        x = 2*theta*rot(omega-phi*omega+phi*pi/2) + sqrt(5)*rot(omega)*x;
        theta = theta*rot(omega-phi*omega+pi);
        % phi the same
    elseif(triangle_num == 3)
        x = 4*theta*rot(omega-phi*omega+phi*pi/2) + sqrt(5)*rot(omega)*x;
        theta = theta*rot(omega-phi*omega+pi);
        phi = -phi;
    elseif(triangle_num == 4)
        x = 2*theta*rot(omega - phi*omega+phi*pi) + sqrt(5)*rot(omega)*x;
        theta = theta*rot(omega-phi*omega+pi);
        phi = -phi;
    elseif(triangle_num == 5)
        x = 2*theta*rot(omega-phi*omega-phi*pi/2) + sqrt(5)*rot(omega)*x;
        theta = theta*rot(omega-phi*omega-phi*pi/2);
        phi = -phi;
    end
end