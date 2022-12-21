function obj = plate37_obj(row, col, N, sg)
% y = linspace(-N/2 + 100, N/2-101, 9);

obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
spacing = 116;

if(row == 1 && col == 1)
    obj(yy >= -3 & yy <= 3) = 1;
elseif(row == 1 && col == 2)
    y = -spacing*2:spacing:spacing*2;
    for i = 1:length(y)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
    end
elseif(row == 1 && col == 3)
    y = -N:spacing:N;
    for i = 1:length(y)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
    end
elseif(row == 2 && col == 1)
    y = -N:spacing:N;
    for i = 1:length(y)
        obj(xx >= (y(i)-3) & xx <= (y(i)+3)) = 1;
    end
elseif(row == 2 && col == 2)
    y = -N:spacing:N;
    for i = 1:length(y)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
    end
    for i = 1:length(y)
        obj(xx >= (y(i)-3) & xx <= (y(i)+3)) = 1;
    end
elseif(row == 2 && col == 3)
    y = -N:spacing:N;
    m1 = 1;
    b1 = y;
    for j = 1:size(b1,2)
        obj(yy+m1*xx >= b1(j)-5 &...
            yy+m1*(xx) <= b1(j)+5) = 1;
    end
elseif(row == 3 && col == 1)
    y = -N:spacing:N;
    m1 = 1; m2 = -1;
    b1 = y; b2 = y;
    for j = 1:size(b1,2)
        obj(yy+m1*xx >= b1(j)-5 &...
            yy+m1*(xx) <= b1(j)+5) = 1;
    end
    for j = 1:size(b2,2)
        obj(yy+m2*xx >= b2(j)-4 &...
            yy+m2*(xx) <= b2(j)+4) = 1;
    end
elseif(row == 3 && col == 2)
    y = -N:spacing:N;
    m1 = 1; m2 = -1;
    b1 = y; b2 = y;
    for j = 1:size(b1,2)
        obj(yy+m1*xx >= b1(j)-5 &...
            yy+m1*(xx) <= b1(j)+5) = 1;
    end
    for j = 1:size(b2,2)
        obj(yy+m2*xx >= b2(j)-4 &...
            yy+m2*(xx) <= b2(j)+4) = 1;
    end
    for i = 1:length(y)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
    end
    for i = 1:length(y)
        obj(xx >= (y(i)-3) & xx <= (y(i)+3)) = 1;
    end
elseif(row == 3 && col == 3)
    y = -N:spacing:N;
    x_space = linspace(-N/2, N/2-1, 7);
    for i = 1:size(y, 2)
        obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
        if(mod(i, 2) ~= 1)
            for j = 1:size(x_space,2)
                obj(xx >= (x_space(j)-20) & xx <= (x_space(j)+20) ...
                    & yy >= (y(i)-3) & yy <= (y(i)+3)) = 0;
            end
        end
    end
elseif(row == 4 && col == 1)
    y = -spacing*2:spacing:spacing*2;
    for i = 1:length(y)
        obj(yy >= (y(i)-6) & yy <= (y(i)+6)) = 1;
    end
elseif(row == 4 && col == 2)
    obj1 = zeros(size(xx));
    obj1(yy >= -3 & yy <= 3) = 1;
    obj = obj + obj1;
    obj1 = zeros(size(xx));
    obj1(xx >= -3 & xx <= 3) = 1;
    obj = obj + obj1;
elseif(row == 4 && col == 3)
    m = [0, 1, -1, 2, -2, 4, -4, 8, -8, 16, -16, 32, -32, 64, -64];
    for i = 1:length(m)
        obj1 = zeros(size(xx));
        obj1(yy+m(i)*xx >= -4 &...
            yy+m(i)*(xx) <= +4) = 1;
        obj = obj + obj1;
    end
end

obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');

end







% if(row ~= 4)
%     % lines and dashes
%     x_space = linspace(-N/2, N/2-1, 7);
%     for i = 1:size(y, 2)
%         obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
%         if(mod(i, 2) ~= 1)
%             for j = 1:size(x_space,2)
%                 obj(xx >= (x_space(j)-20) & xx <= (x_space(j)+20) ...
%                     & yy >= (y(i)-3) & yy <= (y(i)+3)) = 0;
%             end
%         end
%     end
% else
%     % line and into paralleogram
%     y = -N/2:(812/6):N/2-1;
%     m1 = 6;
%     m2 = 1.2;
%     b1 = -10*542:542:4*N;
%     b2 = -10*110:110:3*N;
%     
%     for i = 1:size(y, 2)
%         obj(yy >= (y(i)-3) & yy <= (y(i)+3)) = 1;
%     end
%     for j = 1:size(b1,2)
%         obj(yy+m1*xx >= b1(j)-5 &...
%             yy+m1*(xx) <= b1(j)+5) = 1;
%     end
%     for j = 1:size(b2,2)
%         obj(yy+m2*xx >= b2(j)-4 &...
%             yy+m2*(xx) <= b2(j)+4) = 1;
%     end
% end