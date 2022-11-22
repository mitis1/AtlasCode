function obj = plate05_obj(row,col, N, sg)
    r_hex = 94;
    r_circle = 18;
    if((row == 4 && col == 2) || (row == 1 && col == 3))
        r_big = 25;
    else
        r_big = 0;
    end
    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x, x);
    circle_funct = @(r) draw_circle(xx, yy, r, sg);
    if(row == 1 && col == 1)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
    elseif(row == 1 && col == 2)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
        px = [px, 0];
        py = [py, 0];
    elseif(row == 1 && col == 3)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
        px = [px, 0];
        py = [py, 0];
    elseif(row == 2 && col == 1)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
        px = px + 76;
        py = py + 30;
        px = [px, -218];
        py = [py, -132];
    elseif(row == 2 && col == 2)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
        py = [py, -132, -132];
        px = [px, -288, 288];
    elseif(row == 2 && col == 3)
        px = r_hex*cosd( (0:60:300) + 30 );
        py = r_hex*sind( (0:60:300) + 30 );
        px = px + 76;
        py = py + 30;
        px = [px, -218];
        py = [py, -132];
        px = -px;
        py = py;
    elseif(row == 3 && col == 1)
        px1 = r_hex*cosd( (0:60:300) + 30 );
        py1 = r_hex*sind( (0:60:300) + 30 );
        px1 = px1 + 34;
        py1 = py1 + 110;
        px2 = r_hex*cosd( (0:60:300) + 30 );
        py2 = r_hex*sind( (0:60:300) + 30 );
        px2 = px2 - 46;
        py2 = py2 - 114;
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 3 && col == 2)
        px1 = r_hex*cosd( (0:60:300) + 30 );
        py1 = r_hex*sind( (0:60:300) + 30 );
        px1 = px1 + 26;
        py1 = py1 + 4;
        px2 = r_hex*cosd( (0:60:300) + 30 );
        py2 = r_hex*sind( (0:60:300) + 30 );
        px2 = px2 - 14;
        py2 = py2 - 18;
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 3 && col == 3)  
        px1 = r_hex*cosd( (0:60:300) + 30);
        py1 = r_hex*sind( (0:60:300) + 30);
        px1 = px1 + 160;
        px2 = r_hex*cosd( (0:60:300) + 30 );
        py2 = r_hex*sind( (0:60:300) + 30 );
        px2 = px2 - 160;
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 4 && col == 1)
        px1 = r_hex*cosd( (0:60:300) + 30 );
        py1 = r_hex*sind( (0:60:300) + 30 );
        px2 = r_hex*2*cosd( (0:60:300) + 30 );
        py2 = r_hex*2*sind( (0:60:300) + 30 );
        px = [px1, px2];
        py = [py1, py2];
    elseif(row == 4 && col == 2)
        px1 = r_hex*cosd( (0:60:300) + 30 );
        py1 = r_hex*sind( (0:60:300) + 30 );
        px2 = r_hex*2*cosd( (0:60:300) + 30 );
        py2 = r_hex*2*sind( (0:60:300) + 30 );
        py1 = py1 + (py2(5) - py1(5));
        py2(5) = [];
        px2(5) = [];
        px = [px1, px2];
        py = [py1, py2];
        px([5 end]) = px([end 5]);
        py([5 end]) = py([end 5]);
    elseif(row == 4 && col == 3)
        px1 = r_hex*cosd( (0:60:300) + 30 );
        py1 = r_hex*sind( (0:60:300) + 30 );
        px2 = r_hex*2*cosd( (0:60:300) + 30 );
        py2 = r_hex*2*sind( (0:60:300) + 30 );
        py2 = py2 + 140;
        py1 = py1 - 240;
        px = [px1, px2];
        py = [py1, py2];
    end
    obj = zeros([N N]);
    py = -1*py;
    for i = 1:size(px, 2)
        if(i == size(px, 2) && r_big ~= 0)
            obj = obj + imtranslate(circle_funct(r_big), [px(i), py(i)], 'bilinear');
            continue;
        end
        obj = obj + imtranslate(circle_funct(r_circle), [px(i), py(i)], 'bilinear');
    end
end