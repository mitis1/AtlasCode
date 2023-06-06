% function obj = plate43_obj(row, col, N, sg)
% obj = zeros([N N]);
% x = -N/2:N/2-1;
% [xx, yy] = meshgrid(x, x);
% 
% spacing = 54;
% x1 = -N/2:spacing:N/2;
% [px, py] = meshgrid(x1, x1);
% 
% r_circle = 5;
% r_circle2 = 10;
% obj_funct1 = @() draw_circle(xx, yy, r_circle, sg);
% obj_funct2 = @() draw_circle(xx, yy, r_circle2, sg);
% 
% 
% if(row == 1 && col == 1)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.95)
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
%     return
% elseif(row == 1 && col == 2)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.95)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
%     return
% elseif(row == 1 && col == 3)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.75)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
%     return
% elseif(row == 2 && col == 1)
%     count = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
% 
%             if(count <= 4)
%                 rand_val = randn(1, 1);
%                 if(rand_val >= 0.95)
%                     count = count + 1;
%                 else
%                     obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                     count = count + 1;
%                 end
%             else
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
%                 count = count - 1;
%             end
%         end
%     end
%     return
% elseif(row == 2 && col == 2)
%     count = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             if(count <= 4)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 count = count + 1;
%             else
%                 rand_val = randn(1, 1);
%                 if(rand_val >= 0.95)
%                     count = count - 1;
%                 else
%                     obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
%                     count = count - 1;
%                 end
%             end
%         end
%     end
%     return
% elseif(row == 2 && col == 3)
%     count = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             if(count <= 4)
%                 rand_val = randn(1, 1);
%                 if(rand_val >= 0.95)
%                     count = count + 1;
%                 else
%                     obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                     count = count + 1;
%                 end
%             else
%                 rand_val = randn(1, 1);
%                 if(rand_val >= 0.95)
%                     count = count - 1;
%                 else
%                     obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
%                     count = count - 1;
%                 end
%             end
%         end
%     end
% elseif(row == 3 && col == 1)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.95)
%                 continue
%             end
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.95)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% elseif(row == 3 && col == 2)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.75)
%                 continue
%             end
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.95)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% elseif(row == 3 && col == 3)
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.95)
%                 continue
%             end
%             rand_val = randn(1, 1);
%             if(rand_val >= 0.75)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% elseif(row == 4 && col == 1)
%     has_vacant = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.95)
%                 has_vacant = 1;
%                 continue
%             end
%             if(has_vacant == 1)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%                 has_vacant = 0;
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% elseif(row == 4 && col == 2)
%     has_vacant = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.75)
%                 has_vacant = 1;
%                 continue
%             end
%             if(has_vacant == 1)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%                 has_vacant = 0;
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% elseif(row == 4 && col == 3)
%     has_vacant = 1;
%     for i = 1:size(px, 1)
%         for j = 1:size(px, 2)
%             rand_val1 = randn(1,1);
%             if(rand_val1 >= 0.5)
%                 has_vacant = 1;
%                 continue
%             end
%             if(has_vacant == 1)
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%                 obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
%                 has_vacant = 0;
%             else
%                 obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
%             end
%         end
%     end
% end
% end










































function obj = plate43_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

spacing = 58;
x1 = -N/2:spacing:N/2;
[px, py] = meshgrid(x1, x1);

r_circle = 5;
r_circle2 = 10;
obj_funct1 = @() draw_circle(xx, yy, r_circle, sg);
obj_funct2 = @() draw_circle(xx, yy, r_circle2, sg);


if(row == 1 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.95)
                obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct1(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 1 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.95)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 1 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val = randn(1, 1);
            if(rand_val >= 0.75)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
    return
elseif(row == 2 && col == 1)
    count = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)

            if(count <= 4)
                rand_val = randn(1, 1);
                if(rand_val >= 0.95)
                    count = count + 1;
                else
                    obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                    count = count + 1;
                end
            else
                obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
                count = count - 1;
            end
        end
    end
    return
elseif(row == 2 && col == 2)
    count = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            if(count <= 4)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                count = count + 1;
            else
                rand_val = randn(1, 1);
                if(rand_val >= 0.95)
                    count = count - 1;
                else
                    obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
                    count = count - 1;
                end
            end
        end
    end
    return
elseif(row == 2 && col == 3)
    count = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            if(count <= 4)
                rand_val = randn(1, 1);
                if(rand_val >= 0.95)
                    count = count + 1;
                else
                    obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                    count = count + 1;
                end
            else
                rand_val = randn(1, 1);
                if(rand_val >= 0.95)
                    count = count - 1;
                else
                    obj = obj + imtranslate(obj_funct2(), [px(i, j), py(i, j)], 'bilinear');
                    count = count - 1;
                end
            end
        end
    end
elseif(row == 3 && col == 1)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.95)
                continue
            end
            rand_val = randn(1, 1);
            if(rand_val >= 0.95)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 3 && col == 2)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.75)
                continue
            end
            rand_val = randn(1, 1);
            if(rand_val >= 0.95)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 3 && col == 3)
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.95)
                continue
            end
            rand_val = randn(1, 1);
            if(rand_val >= 0.75)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 1)
    has_vacant = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.95)
                has_vacant = 1;
                continue
            end
            if(has_vacant == 1)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
                has_vacant = 0;
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 2)
    has_vacant = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.75)
                has_vacant = 1;
                continue
            end
            if(has_vacant == 1)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
                has_vacant = 0;
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
elseif(row == 4 && col == 3)
    has_vacant = 1;
    for i = 1:size(px, 1)
        for j = 1:size(px, 2)
            rand_val1 = randn(1,1);
            if(rand_val1 >= 0.5)
                has_vacant = 1;
                continue
            end
            if(has_vacant == 1)
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
                obj = obj + imtranslate(obj_funct2(), [px(i, j) + spacing/2, py(i, j) + spacing/2], 'bilinear');
                has_vacant = 0;
            else
                obj = obj + imtranslate(obj_funct1(), [px(i, j), py(i, j)], 'bilinear');
            end
        end
    end
end
end