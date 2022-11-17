function [row, col] = find_circle_centers(radius,num_pts, mat_size_x, mat_size_y)
    % radius in pixels
    if(mod(num_pts,2) == 0)
        angles = linspace(0, 2*pi, num_pts + 1);
    else
        angles = linspace(-pi/2, (3/2)*pi, num_pts + 1);
    end
    mid_x = (mat_size_x + 1)/2;
    mid_y = (mat_size_y + 1)/2;
    for i = 1:length(angles)
        [x, y] = pol2cart(angles(i), radius);
        x = round(x);
        y = round(y);
        x = x + mid_x;
        y = y + mid_y;
        row(i) = y;
        col(i) = x;
    end
end