function obj = plate45_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
x2 = -N:N-1;
[xx2, yy2] = meshgrid(x2, x2);
r = 10;
spacing = 35;
obj_funct = @() draw_circle(xx2, yy2, r, sg);
obj1 = zeros(size(xx2,1), size(xx2,2));
if(row == 2 || row == 1)
    px1 = -N:spacing:N-1;
    [px, py] = meshgrid(px1, px1);  
    for i = 1:size(px,1)
        for j = 1:size(px, 2)
            obj1 = obj1 + imtranslate(obj_funct(), [px(i,j), py(i,j)], 'bilinear');
        end
    end
elseif(row == 4 || row == 3)
    y = -N:spacing:N;
    x = -N:spacing:N;
    for i = 1:size(y, 2)
        if(mod(i, 2) == 1)
            offset = spacing/2;
        else
            offset = 0;
        end
        for j = 1:size(x, 2)
            obj1 = obj1 + imtranslate(obj_funct(), [x(j)+offset, y(i)], 'bilinear');
        end
    end
end
obj = zeros(size(xx));
scale = N/2;
offset = -N/4;
scale2 = N;
offset2 = -N/2;

if(row == 1 && col == 1)
    P = rand([5 2])*scale + offset;
elseif(row == 1 && col == 2)
    P = rand([20 2])*scale + offset;
elseif(row == 1 && col == 3)
    P = rand([40 2])*scale + offset;
elseif(row == 2 && col == 1)
    P = rand([5 2])*scale2 + offset2;
elseif(row == 2 && col == 2)    
    P = rand([20 2])*scale2 + offset2;
elseif(row == 2 && col == 3)
    P = rand([40 2])*scale2 + offset2;
elseif(row == 3 && col == 1)
    P = rand([5 2])*scale + offset;
elseif(row == 3 && col == 2)
    P = rand([20 2])*scale + offset;
elseif(row == 3 && col == 3)
    P = rand([40 2])*scale + offset;
elseif(row == 4 && col == 1)
    P = rand([5 2])*scale2 + offset2;
elseif(row == 4 && col == 2)
    P = rand([20 2])*scale2 + offset2;
elseif(row == 4 && col == 3)
    P = rand([40 2])*scale2 + offset2;
end

% x = -N/2:N/2-1;
    xx1 = reshape(xx, [1, size(xx,1)*size(xx,2)]);
    yy1 = reshape(yy, [1, size(yy,1)*size(yy,2)]);
%     P = rand([20 2])*N - N/2;
    DT = delaunayTriangulation(P);
    [vx,vy] = voronoi(DT);
    [V, C, XY] = VoronoiLimit(vx, vy, 'figure', 'off');
    
    for i = 1:size(C, 1)
        in = inpolygon(xx1, yy1, V(C{i,1}(:),1), V(C{i,1}(:),2));
        in = reshape(in, size(xx, 1), size(xx,2));
        mask = zeros(size(xx));
        mask(in) = 1;
        rot_val = rand(1,1)*360;
        obj2 = imrotate(obj1, rot_val, 'bilinear', 'crop');
        obj2 = obj2(N/2:N*(3/2)-1, N/2:N*(3/2)-1);
        obj2 = obj2 .* mask;
        obj = obj2 + obj;
    end

end