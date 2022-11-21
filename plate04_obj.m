function obj = plate04_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 25;
r_outer = 140;
r_hex = 80;
circle = @( ) draw_circle(xx, yy, r, sg);

hex_x = r_outer*cosd( (0:60:300) );
hex_y = r_outer*sind( (0:60:300) );
hex_x(end+1) = 0;
hex_y(end+1) = 0;

px = r_hex*cosd( (0:60:300) + 30);
py = r_hex*sind( (0:60:300) + 30);

hex_count = 1;
pts_count = 1;
obj = zeros([N, N]);
if(~isempty(rm_hex) && rm_hex(length(rm_hex)) == 7)
    if(rm_hex(1) ~= 1) % two in a row
        x_avg = (hex_x(7) + hex_x(1))/2;
        hex_x = [hex_x(7) - x_avg, hex_x(1) - x_avg];
        hex_y = [0, 0];
    else % two diagonal
        x_avg = (hex_x(1) + hex_x(3))/2;
        y_avg = (hex_y(1) + hex_y(3))/2;
        hex_x = [hex_x(1) - x_avg, hex_x(3) - x_avg];
        hex_y = [hex_y(1) - y_avg, hex_y(3) - y_avg];
    end
    for j = 1:size(px,2)
        obj = obj + circle(hex_x(1) + px(j), hex_y(1) + py(j));
        obj = obj + circle(hex_x(2) + px(j), hex_y(2) + py(j));
    end
    return
end

for i = 1:size(hex_x, 2)
    pts_count = 1;
    if(~isempty(rm_hex) && length(rm_hex) >= hex_count && rm_hex(hex_count) == i)
        hex_count = hex_count + 1;
        continue
    end
    for j = 1:size(px, 2)
        if(i ~= 7 && ~isempty(rm_pts) && length(rm_pts) >= pts_count && rm_pts(pts_count) == j)
            pts_count = pts_count + 1;
            continue
        end
        obj = obj + circle(hex_x(i) + px(j), hex_y(i) + py(j));
%         figure;
%         imagesc(obj);
    end
end
obj(obj>2) = obj(obj>2)/3;
obj(obj>1) = obj(obj>1)/2;
end