function obj = plate19_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r_circle = 3;
spacing = 14;
circle_funct = @( ) draw_circle(xx, yy, r_circle, sg);
x_a = -N/2:spacing:N/2;
x_b = x_a + spacing/3;
x_c = x_a + 2*spacing/3;
y = -N/2:spacing:N/2;
obj = zeros(size(xx));
if(row == 1 && col == 1)
    alpha = 1;
    beta = 1;
elseif(row == 1 && col == 2)
    alpha = 0.9;
    beta = 0.9;
elseif(row == 1 && col == 3)
    alpha = 0.7;
    beta = 0.7;
elseif(row == 2 && col == 1)
    alpha = 0.003;
    beta = 0.003;
elseif(row == 2 && col == 2)
    alpha = 0.1;
    beta = 0.1;
elseif(row == 2 && col == 3)
    alpha = 0.3;
    beta = 0.3;
elseif(row == 3 && col == 1)
    alpha = 0;
    beta = 1;
elseif(row == 3 && col == 2)
    alpha = 0.1;
    beta = 1;
elseif(row == 3 && col == 3)
    alpha = 0.3;
    beta = 1;
elseif(row == 4 && col == 1)
    alpha = 0.5;
    beta = 0.5;
elseif(row == 4 && col == 2)
    alpha = 0.1;
    beta = 0.5;
elseif(row == 4 && col == 3)
    alpha = 0.3;
    beta = 0.5;
end
prev = [1,2];
for i = 1:size(y, 2)
    val = rand(1,1);
    %AB
    if(prev == [1,2])
        if(val <= alpha)
            x = x_a;
            prev = [2,1];
        else
            x = x_c;
            prev = [2,3];
        end
    %BA
    elseif(prev == [2,1])
        if(val <= beta)
            x = x_b;
            prev = [1,2];
        else
            x = x_c;
            prev = [1,3];
        end
    %BC
    elseif(prev == [2,3])
        if(val <= alpha)
            x = x_b;
            prev = [3,2];
        else
            x = x_a;
            prev = [3,1];
        end
    %CB
    elseif(prev == [3,2])
        if(val <= beta)
            x = x_c;
            prev = [2,3];
        else
            x = x_a;
            prev = [2,1];
        end
    %CA
    elseif(prev == [3,1])
        if(val <= alpha)
            x = x_c;
            prev = [1,3];
        else
            x = x_b;
            prev = [1,2];
        end
    %AC
    elseif(prev == [1,3])
        if(val <= beta)
            x = x_a;
            prev = [3,1];
        else
            x = x_b;
            prev = [3,2];
        end
    end
    for j = 1:size(x, 2)
        obj = obj + imtranslate(circle_funct(), [x(j), y(i)], 'bilinear');
    end
end
end