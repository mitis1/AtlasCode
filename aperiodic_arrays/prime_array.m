function [px,py] = prime_array(num,N)
p = isprime(0:num^2-1);
p = reshape(p, [num,num]);
[py, px] = find(p);

ratio = N/(max(px)-min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end