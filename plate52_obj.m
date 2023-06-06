function obj = plate52_obj(row, col, N, sg)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
w = 1;
h = 3;
obj_funct = @() draw_rectangle(xx, yy, w, h, sg);
amp = 100;
freq2 = 2;
num_lines = 30;
num_lines2 = 40;
if(row == 1 && col == 1)
    obj(yy >= -3 & yy <= 3) = 1;
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
    return
elseif(row == 1 && col == 2)
    offset = 25;
    obj(yy+offset >= -3 & yy+offset <= 3) = 1;
    obj(yy-offset >= -3 & yy-offset <= 3) = 1;
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
    return
elseif(row == 1 && col == 3)
    offset = 45;
    obj(yy+offset >= -3 & yy+offset <= 3) = 1;
    obj(yy-offset >= -3 & yy-offset <= 3) = 1;
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
    return
elseif(row == 2 && col == 1)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    px = [px];
    py = [py1];
elseif(row == 2 && col == 2)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    py2 = amp*sind((px+180));
    px = [px,px];
    py = [py1,py2];
elseif(row == 2 && col == 3)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    py2 = amp*sind((px+360*(3/8)));
    px = [px,px];
    py = [py1,py2];
elseif(row == 3 && col == 1)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    px = [px];
    py = [py1];
    px2 = -N/2:num_lines:N/2;
elseif(row == 3 && col == 2)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    px = [px];
    py = [py1];
    px2 = -N/2:num_lines2:N/2;
elseif(row == 3 && col == 3)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(freq2*px);
    px = [px];
    py = [py1];
    px2 = -N/2:num_lines:N/2;
elseif(row == 4 && col == 1)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    py2 = amp*sind((px+180));
    px = [px,px];
    py = [py1,py2];
    px2 = -N/2:num_lines:N/2;
elseif(row == 4 && col == 2)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    py2 = amp*sind((px+180));
    px = [px,px];
    py = [py1,py2];
    px2 = -N/2:num_lines2:N/2;
elseif(row == 4 && col == 3)
    px = -N/2:0.5:N/2-1;
    py1 = amp*sind(px);
    py2 = amp*sind((px+135));
    px = [px,px];
    py = [py1,py2];
    px2 = -N/2:num_lines:N/2;
end

obj1 = zeros(size(xx));
for i = 1:size(px,2)
    obj1 = obj1 + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
    obj1(obj1>1) = obj1(obj1>1)/2;
end

if(row == 3)
    for i = 1:size(px2,2)
        obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 1;
        if(col == 3)
            if(amp*sind(freq2*px2(i))<0)
                obj(yy<amp*sind(freq2*px2(i)) & ...
                xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy>0 & ...
                xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            elseif(amp*sind(freq2*px2(i)) > 0)
                obj(yy>amp*sind(freq2*px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy<0 & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            else
                obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            end
        else
            if(amp*sind(px2(i))<0)
                obj(yy<amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy>0 & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            elseif(amp*sind(px2(i))>0)
                obj(yy>amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy<0 & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            else
                obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            end
        end
    end
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
elseif(row == 4)
    for i = 1:size(px2,2)
        obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 1;
        if(col == 3)
            if(amp*sind(px2(i)) < 0)
                obj(yy<amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy>amp*sind((px2(i)+135)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            elseif(amp*sind(px2(i)) > 0)
                obj(yy>amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy<amp*sind((px2(i)+135)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            else
                obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            end
        else
            if(amp*sind(px2(i)) < 0)
                obj(yy<amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy>amp*sind((px2(i)+180)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            elseif(amp*sind(px2(i)) > 0)
                obj(yy>amp*sind(px2(i)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
                obj(yy<amp*sind((px2(i)+180)) & ...
                    xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            else
                obj(xx >= px2(i)-3 & xx <= px2(i)+3) = 0;
            end
        end
    end
    obj = imgaussfilt(obj, sg, 'FilterDomain', 'frequency');
end
obj = obj + obj1;
end