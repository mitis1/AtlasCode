function [px,py] = coprime_array(arr_sz,N)
x_val  = 2:arr_sz;
[xx1, yy1] = meshgrid(x_val, x_val);
obj = zeros(size(xx1));
obj(gcd(xx1, yy1) == 1) = 1;
[py, px] = find(obj);

% figure
%     scatter(px, py, "filled")

ratio = N/(max(px)-min(px));
px = px .* ratio;
py = py .* ratio;
px = px - N/2 - min(px);
py = py - N/2 - min(py);
end