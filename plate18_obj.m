function obj = plate18_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);
r = 3;
circle_funct = @( ) draw_circle(xx, yy, r, sg);
sz1 = 75;
% if(row == 1 && col == 1)
%     obj = zeros(size(xx));
%     return;
% elseif(row == 1 && col == 2)
%     obj = zeros(size(xx));
%     return;
% elseif(row == 1 && col == 3)
%     obj = zeros(size(xx));
%     return;
% end
% 
if(row == 1 && col == 1)
    alpha = 0;
    beta = 0.1;
elseif(row == 1 && col == 2)
    alpha = 0;
    beta = 0.3;
elseif(row == 1 && col == 3)
    alpha = 0;
    beta = 0.5;
elseif(row == 2 && col == 1)
    alpha = 0.3;
    beta = 0.1;
elseif(row == 2 && col == 2)
    alpha = 0.3;
    beta = 0.3;
elseif(row == 2 && col == 3)
    alpha = 0.3;
    beta = 0.5;
elseif(row == 3 && col == 1)
    alpha = 0.7;
    beta = 0.1;
elseif(row == 3 && col == 2)
    alpha = 0.7;
    beta = 0.3;
elseif(row == 3 && col == 3)
    alpha = 0.7;
    beta = 0.5;
elseif(row == 4 && col == 1)
    alpha = 0.1;
    beta = 0.1;
elseif(row == 4 && col == 2)
    alpha = 0.1;
    beta = 0.3;
elseif(row == 4 && col == 3)
    alpha = 0.1;
    beta = 0.5;
end

grid = zeros([500, 500]);
gamma = 1-beta-alpha;
beta = beta - alpha;
% delta = 1-alpha;
delta = 0;

for i = 1:size(grid, 1)
    rand_val = rand(1,1);
    rand_val2 = rand(1,1);
    if(row == 1 || row == 4); pr = 0.5; else; pr = 0; end
    if(rand_val <= pr)
        grid(1,i) = 1;
    end
    if(rand_val2 <= pr)
        grid(i,1) = 1;
    end
end
grid(1,1) = 0;
grid(1,2) = 0;
for i = 2:size(grid, 1)
    for j = 2:size(grid, 2)
        rand_val = rand(1,1);
        pr = alpha + beta*grid(i-1,j)+gamma*grid(i,j-1)+delta*grid(i-1,j)*grid(i,j-1);
        if(rand_val <= pr)
            grid(i,j) = 1;
        end
    end
end
grid = grid(10:sz1-10, 10:sz1-10);
[py, px] = find(grid);
 
ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
obj = zeros(size(xx));
for i = 1:size(px,1)
    obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
end

end