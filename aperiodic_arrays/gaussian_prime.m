function [px,py] = gaussian_prime(N, arr_sz)
x_val = -arr_sz:arr_sz-1;
[xx1, yy1] = meshgrid(x_val, x_val);
p = isprime(xx1.^2 + yy1.^2);
[py, px] = find(p);
ratio = N/(max(px) - min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (N/2+min(px));
py = py - (N/2+min(py));
end