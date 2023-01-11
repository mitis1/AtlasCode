function obj = plate39_obj(row, col, N, sg)
 % basic crystals
    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x, x);
    r = 15;
    r2 = 5;
    spacing = 58;
    circle_funct = @( ) draw_circle(xx, yy, r, sg);
    circle_funct2 = @( ) draw_circle(xx, yy, r2, sg);
    obj = zeros(size(xx));
    line = @(y, slope, int) y*slope + int; 

    % square spacing
    if(row == 1 && col == 1)
        y = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            for j = 1:size(y, 2)
                obj = obj + imtranslate(circle_funct(), [y(i), y(j)], 'bilinear');
            end
        end
    % rectangle spacing
    elseif(row == 1 && col == 2)
        y = -N/2:spacing:N/2;
        x = -N/2:spacing*1.5:N/2;
        for i = 1:size(x, 2)
            for j = 1:size(y, 2)
                obj = obj + imtranslate(circle_funct(), [x(i), y(j)], 'bilinear');
            end
        end
    % hexagonal lattice
    elseif(row == 1 && col == 3)
        y = -N/2:spacing*(sqrt(3)/2):N/2;
        x = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            if(mod(i, 2) == 1)
                offset = spacing/2;
            else
                offset = 0;
            end
            for j = 1:size(x, 2)
                obj = obj + imtranslate(circle_funct(), [x(j)+offset, y(i)], 'bilinear');
%                 figure(4)
%                     imagesc(obj)
            end
        end
    % rectangular lattice
    elseif(row == 2 && col == 1)
        y = -N/2:spacing*(1/2):N/2;
        x = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            if(mod(i, 2) == 1)
                offset = spacing/2;
            else
                offset = 0;
            end
            for j = 1:size(x, 2)
                obj = obj + imtranslate(circle_funct(), [x(j)+offset, y(i)], 'bilinear');
%                 figure(4)
%                     imagesc(obj)
            end
        end
    elseif(row == 2 && col == 2)
        slope = -1/4;
        px_spacing = spacing; py_spacing = spacing;
        px_int = -N/2-px_spacing:px_spacing:N/2-1+2*px_spacing;
        py = -N/2-py_spacing:py_spacing:N/2-1+py_spacing;
        
        for i = 1:size(py,2)
            for j = 1:size(px_int,2)
                px = line(py(i), slope, px_int(j));
                obj = obj + imtranslate(circle_funct(), [px, py(i)], 'bilinear');
%                 figure(4)
%                     imagesc(obj)
            end
        end
    elseif(row == 2 && col == 3)
        slope = 1/4;
        px_spacing = spacing; py_spacing = spacing;
        px_int = -N-px_spacing:px_spacing:N-1+2*px_spacing;
        py = -N-py_spacing:py_spacing:N-1+2*py_spacing;
        
        for i = 1:size(py,2)
            for j = 1:size(px_int,2)
                px = line(py(i), slope, px_int(j));
                obj = obj + imtranslate(circle_funct(), [px, py(i)], 'bilinear');
            end
        end
    elseif(row == 3 && col == 1)
%         spacing = 29; 
        y = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            for j = 1:size(y, 2)
                obj = obj + imtranslate(circle_funct2(), [y(i), y(j)], 'bilinear');
            end
        end
    elseif(row == 3 && col == 2)
%         spacing = 29; 
        y = -N/2:spacing:N/2;
        x = -N/2:spacing*1.5:N/2;
        for i = 1:size(x, 2)
            for j = 1:size(y, 2)
                obj = obj + imtranslate(circle_funct2(), [x(i), y(j)], 'bilinear');
            end
        end
    elseif(row == 3 && col == 3)
%         spacing = 29;
        y = -N/2:spacing*(sqrt(3)/2):N/2;
        x = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            if(mod(i, 2) == 1)
                offset = spacing/2;
            else
                offset = 0;
            end
            for j = 1:size(x, 2)
                obj = obj + imtranslate(circle_funct2(), [x(j)+offset, y(i)], 'bilinear');
%                 figure(4)
%                     imagesc(obj)
            end
        end
    elseif(row == 4 && col == 1)
%         spacing = 29;
        y = -N/2:spacing*(1/2):N/2;
        x = -N/2:spacing:N/2;
        for i = 1:size(y, 2)
            if(mod(i, 2) == 1)
                offset = spacing/2;
            else
                offset = 0;
            end
            for j = 1:size(x, 2)
                obj = obj + imtranslate(circle_funct2(), [x(j)+offset, y(i)], 'bilinear');
%                 figure(4)
%                     imagesc(obj)
            end
        end
    elseif(row == 4 && col == 2)
%         spacing = 29;
        slope = -1/4;
        px_spacing = spacing; py_spacing = spacing;
        px_int = -N/2-px_spacing:px_spacing:N/2-1+2*px_spacing;
        py = -N/2-py_spacing:py_spacing:N/2-1+py_spacing;
        
        for i = 1:size(py,2)
            for j = 1:size(px_int,2)
                px = line(py(i), slope, px_int(j));
                obj = obj + imtranslate(circle_funct2(), [px, py(i)], 'bilinear');
            end
        end
    elseif(row == 4 && col == 3)
        slope = 1/4;
%         spacing = 29;
        px_spacing = spacing; py_spacing = spacing;
        px_int = -N-px_spacing:px_spacing:N-1+2*px_spacing;
        py = -N-py_spacing:py_spacing:N-1+py_spacing;
        
        for i = 1:size(py,2)
            for j = 1:size(px_int,2)
                px = line(py(i), slope, px_int(j));
                obj = obj + imtranslate(circle_funct2(), [px, py(i)], 'bilinear');
            end
        end
    end
end