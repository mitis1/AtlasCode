function obj = plate54_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x, x);
r = 10;
circle_funct = @() draw_circle(xx, yy, r, sg);
%mul, ep, iter, startT, dT
% datanumber = melting_code(1,1.3,100,170,0.2); % mul = 1, ep = 1.3, iter = 100, 170, dT = 0.2
datanumber = 327254261;
load(sprintf('hexatic_melting_code/data/%d.mat',datanumber),"posSLs");
if(row == 1 && col == 1)
    indT = 1;
elseif(row == 1 && col == 2)
    indT = 2;
elseif(row == 1 && col == 3)
    indT = 3;
elseif(row == 2 && col == 1)
    indT = 4;
elseif(row == 2 && col == 2)
    indT = 5;
elseif(row == 2 && col == 3)
    indT = 6;
elseif(row == 3 && col == 1)
    indT = 7;
elseif(row == 3 && col == 2)
    indT = 8;
elseif(row == 3 && col == 3)
    indT = 9;
elseif(row == 4 && col == 1)
    indT = 10;
elseif(row == 4 && col == 2)
    indT = 11;
elseif(row == 4 && col == 3)
    indT = 12;
end
px = [];
py = [];
px = posSLs(:,1,indT);
py = posSLs(:,2,indT);
ratio = N/(max(px)-min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
obj = zeros(size(xx));
for i = 1:size(px,1)
    obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
end
end

% 327254261: mul = 1, ep = 1.3, iter = 100, 170, dT = 0.2