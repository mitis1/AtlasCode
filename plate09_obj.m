function obj = plate09_obj(row, col, N, sg)
y = linspace(-N/2 + 100, N/2-101, 9);
r = 15;
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
circle_funct = @() draw_circle(xx, yy, r, sg);

if(row == 1)
    if(col == 1)
        px = [375, 175, 280, 550, 200, 360, 560, 225, 440, 520];
        py = [y(1), y(3), y(3), y(3), y(5), y(5), y(5), y(7), y(7), y(9)];
    elseif(col == 2)
        px = [375, 473, 263, 238, 342, 504, 658, 360, 310, 620];
        py = [y(1), y(1), y(3), y(5), y(5), y(5), y(5), y(7), y(9), y(9)];
    elseif(col == 3)
        px = [185, 474, 262, 419, 136, 398, 149, 418, 555, 352];
        py = [y(1), y(1), y(3), y(3), y(5), y(5), y(7), y(7), y(7), y(9)];
    end
    px = px - N/2;
end
if(row == 2)
    mid = (y(2) - y(1))/2;
    if(col == 1)
        px = [329, 337, 225, 416, 442, 401, 202, 404, 478, 643];
        py = [y(1), y(2), y(3), y(3), y(5), y(6), y(7), y(7), y(9), y(9)];
    elseif(col == 2)
        px = [454, 182, 354, 562, 276, 408, 208, 346, 522, 603];
        py = [y(1), y(3), y(3), y(3), y(5), y(5), y(7), y(7), y(7), y(7)] + mid;
    elseif(col == 3)
        px = [257, 408, 340, 288, 370, 623, 542, 396, 259, 276];
        py = [y(1) + mid, y(2), y(3), y(4)+mid, y(5)+mid, y(5)+mid, y(6), y(6)+mid, y(7), y(8)+mid];
    end
    px = px - N/2;
end
if(row == 3)
    if(col == 1)
        px = [329, 230, 434, 590, 322, 456, 197, 354, 555, 454];
        py = [y(1), y(3), y(3), y(3), y(5), y(5), y(7), y(7), y(7), y(9)];
    elseif(col == 2)
        px = [263, 375, 250, 495, 594, 200, 296, 542, 406, 523];
        py = [y(2), y(2), y(4), y(4), y(4), y(7), y(7), y(7), y(9), y(9)];
    elseif(col == 3)
        px = [230, 370, 396, 583, 256, 526, 226, 402, 437, 570];
        py = [y(2), y(2), y(4), y(4), y(5), y(5), y(6), y(6), y(8), y(8)];
    end
    px = px - N/2;
end
if(row == 4)
    if(col == 1)
        px = [270, 248, 227, 316, 294, 406, 430, 520, 475, 588];
        py = [137, 272, 407, 407, 542, 407, 269, 271, 541, 407];
    elseif(col == 2)
        px = [270, 248, 227, 359, 294, 452, 406, 384, 543, 520];
        py = [137, 272, 407, 137, 542, 136, 407, 543, 135, 271];
    elseif(col == 3)
        px = [248, 360, 339, 316, 453, 428, 385, 497, 610, 565];
        py = [272, 138, 269, 406, 135, 272, 543, 406, 271, 543];
    end
    px = px - N/2;
    py = py - N/2;
end

% py = -py;
for i = 1:size(px, 2)
    obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
end

if(row ~= 4)
    % lines and dashes
    x_space = linspace(-N/2, N/2-1, 7);
    for i = 1:size(y, 2)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 0.25;
        if(mod(i, 2) ~= 1)
            for j = 1:size(x_space,2)
                obj(xx >= (x_space(j)-20) & xx <= (x_space(j)+20) ...
                    & yy >= (y(i)-3) & yy <= (y(i)+3)) = 0;
            end
        end
    end
else
    % line and into paralleogram
    y = -N/2:(812/6):N/2-1;
    m1 = 6;
    m2 = 1.2;
    b1 = -10*542:542:4*N;
    b2 = -10*110:110:3*N;
    
    for i = 1:size(y, 2)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 0.25;
    end
    for j = 1:size(b1,2)
        obj(yy+m1*xx >= b1(j)-5 &...
            yy+m1*(xx) <= b1(j)+5) = 0.25;
    end
    for j = 1:size(b2,2)
        obj(yy+m2*xx >= b2(j)-4 &...
            yy+m2*(xx) <= b2(j)+4) = 0.25;
    end
end

end