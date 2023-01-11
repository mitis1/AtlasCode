function [v1, v2, v3] = get_pts(points_arr)
    x = points_arr(1);
    theta = points_arr(2);
    phi = points_arr(3);
    v1 = x + (theta + theta*rot(-phi*pi/2));
    v2 = x + (theta*rot(pi) + theta*rot(-phi*pi/2));
    v3 = x + (theta*rot(pi) + 3*theta*rot(phi*pi/2));
end