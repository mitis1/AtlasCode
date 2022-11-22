function obj = plate04_obj(row, col, N, sg)
    x = -N/2:N/2-1;
    [xx, yy] = meshgrid(x, x);
    r = 25;
    r_outer = 140;
    r_hex = 80;
    circle_funct = @( ) draw_circle(xx, yy, r, sg);
    
    if(row == 1 && col == 1)
        rm_pts = [];
        rm_hex = [1, 2, 3, 4, 5, 6];
    elseif(row == 1 && col == 2)
        rm_pts = [1, 2, 3, 4, 6];
        rm_hex = [1, 2, 3, 5, 6];
    elseif(row == 1 && col == 3)
        rm_pts = [1,2,3,6,0;1,2,3,5,6];
        rm_hex = [1,2,3,6];
    elseif(row == 2 && col == 1)
        rm_hex = [1,2,3,5,6];
        rm_pts = [1,3,4,6];
    elseif(row == 2 && col == 2)
        rm_pts = [];
        rm_hex = [2,3,4,5,6,7];
    elseif(row == 2 && col == 3)
        rm_pts = [];
        rm_hex = [2,3,4,6,7];
    elseif(row == 3 && col == 1)
        rm_pts = [1,3,4,6];
        rm_hex = [2,3,5,6];
    elseif(row == 3 && col == 2)
        rm_pts = [];
        rm_hex = [2,3,5,6];
    elseif(row == 3 && col == 3)
        rm_pts = [];
        rm_hex = [1,3,5];
    elseif(row == 4 && col == 1)
        rm_pts = [1,3];
        rm_hex = [];
    elseif(row == 4 && col == 2)
        rm_pts = [];
        rm_hex = [3,6];
    elseif(row == 4 && col == 3)
        rm_pts = [];
        rm_hex = [];
    end
    
    px = zeros([7, 6]);
    py = zeros([7, 6]);
    px(1:6,:) = r_outer*cosd( (0:60:300)' ).* ones([1,6]);
    py(1:6,:) = r_outer*sind( (0:60:300)' ).* ones([1,6]);
    
    for i = 1:7
        px(i,:) = px(i,:) + r_hex*cosd( (0:60:300) + 30);
        py(i,:) = py(i,:) + r_hex*sind( (0:60:300) + 30);
    end
    
    obj = zeros([N, N]);
    if(row == 2 && col == 2)
        x_avg = px(7,6);
        px = [px(7,:)-x_avg; px(1,:) - x_avg];
        py = [py(7,:); py(1,:)];
    elseif(row == 2 && col == 3)
        x_avg = (px(1,4) + px(5,1))/2;
        y_avg = (py(1,4) + py(5,1))/2;
        px = [px(1,:) - x_avg, px(5,:) - x_avg];
        py = [py(1,:) - y_avg, py(5,:) - y_avg];
    elseif(row == 4 && col == 1)
        count = [3,4,5,6,1,2];
        for i = 1:6
            px1(i) = px(count(i),i);
            py1(i) = py(count(i),i);
        end
        py = [py1, py(7,:)];
        px = [px1, px(7,:)];
    else
        count1 = 1; count2 = 1;count3 = 1;
        for i = 1:size(px,1)-1
            if(count1 <= length(rm_hex) && rm_hex(count1) == i)
                px(i,:) = zeros([1,6]) - 10000;
                py(i,:) = zeros([1,6]) - 10000;
                count1 = count1 + 1;
                continue;
            end
            count2 = 1;
            if(i == 5); count3 = count3 + 1; end
            for j = 1:size(px,2)
                if(row == 1 && col == 3)
                    if(count2 <= size(rm_pts,2) && rm_pts(count3,count2) == j)
                        px(i,j) = -10000;
                        py(i,j) = -10000;
                        count2 = count2 + 1;
                    end
                elseif(count2 <= length(rm_pts) && rm_pts(count2) == j)
                    px(i,j) = -10000;
                    py(i,j) = -10000;
                    count2 = count2 + 1;
                end
            end
        end
    end
    
    coords = [px(:),py(:)];
    coords = unique(coords, 'rows');
    
    for i = 1:size(px, 1)
        for j = 1:size(px,2)
            obj = obj + imtranslate(circle_funct(), [px(i,j), py(i,j)], 'bilinear');
        end
    end
    obj(obj>2) = obj(obj>2)/3;
    obj(obj>1) = obj(obj>1)/2;
end