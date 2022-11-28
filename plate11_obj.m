function obj = plate11_obj(row, col, N, sg)
    % col 1
    x_spacing1 = 50;
    y_spacing1 = 38;
    % col 2
    x_spacing2 = 72;
    y_spacing2 = 72;
    % col 3
    tilt_angle = -15;
    r_hex = 15;
    r = 3;
    px_hex = r_hex*cosd( (0:60:300) );
    py_hex = r_hex*sind( (0:60:300) );
    x = -N/2:N/2-1;
    [xx,yy] = meshgrid(x, x);
    circle = @(x0,y0) imtranslate(draw_circle(xx, yy, r, sg), [x0, y0], 'bilinear');
    if(row == 1)
        if(col == 1)
            px = [-x_spacing1/2, x_spacing1/2+1];
        else
            px = [-x_spacing2/2, x_spacing2/2+1];
        end
        py = [0, 0];
        if(col == 3); py = [y_spacing2/4+1, -y_spacing2/4]; end
    elseif(row == 2)
        if(col == 1)
            px = [-x_spacing1/2, -x_spacing1/2, x_spacing1/2+1, x_spacing1/2+1];
            py = [-y_spacing1/2, y_spacing1/2+1, -y_spacing1/2, y_spacing1/2+1];
        else
            px = [-x_spacing2/2, -x_spacing2/2, x_spacing2/2+1, x_spacing2/2+1];
            py = [-y_spacing2/2, y_spacing2/2+1, -y_spacing2/2, y_spacing2/2+1];
        end
        if(col == 3)
            py = [-y_spacing2/2+y_spacing2/4, y_spacing2/2+1+y_spacing2/4, -y_spacing2/2-y_spacing2/4, y_spacing2/2+1-y_spacing2/4];
        end
    elseif(row == 3)
        if(col == 1)
            py = -N/2+y_spacing1/2:y_spacing1:N/2-y_spacing1/2-1;
            px = ones(size(py));
            px = [-x_spacing1/2*px, (x_spacing1/2+1)*px];
            py = [py, py];
        else
            py = -N/2+y_spacing2/2:y_spacing2:N/2-y_spacing2/2-1;
            px = ones(size(py));
            px = [-x_spacing2/2*px, (x_spacing2/2+1)*px];
            if(col == 3)
                py = [py-y_spacing2/4, py+y_spacing2/4];
            else
                py = [py, py];
            end
        end
    elseif(row == 4)
       if(col == 1)
           px = -N/2+y_spacing1/2:x_spacing1:N/2-y_spacing1/2-1;
           py = -N/2+y_spacing1/2:y_spacing1:N/2-y_spacing1/2-1;
           [px, py] = meshgrid(px, py);
       elseif(col == 2)
           px = -N/2+x_spacing2/2:x_spacing2:N/2-x_spacing2/2-1;
           py = -N/2+y_spacing2/2:y_spacing2:N/2-y_spacing2/2-1;
           [px, py] = meshgrid(px, py);
       elseif(col == 3)

           px = -N/2-x_spacing2/2:x_spacing2:N/2-1+x_spacing2/2;
           py = -N/2-y_spacing2/2:y_spacing2:N/2-1+y_spacing2/2;
           [px, py] = meshgrid(px, py);
           py_offset = [-y_spacing2/4, 0, y_spacing2/4, y_spacing2/2];
           count = 2;
           for i = 1:size(py, 2)
                py(:, i) = py(:, i) + py_offset(count);
                count = mod(count+1,4);
                if(count == 0); count = 1; end
           end
       end
    end
    obj = zeros(size(xx));
    if(col == 3)
        [theta, rho] = cart2pol(px, py);
        theta = theta + (tilt_angle*(pi/180));
        [px, py] = pol2cart(theta, rho);
    end
    if(row == 4)
        for i = 1:size(px,2)
            for j = 1:size(px,1)
                for k = 1:size(px_hex, 2)
                    obj = obj + circle(px(j,i)+px_hex(k), py(j,i)+py_hex(k));
                end
            end
        end

    else
        for i = 1:size(px, 2)
            for k = 1:size(px_hex, 2)
                obj = obj + circle(px(i)+px_hex(k), py(i)+py_hex(k));
            end
        end
    end

end