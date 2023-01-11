function [px,py] = ulam_spiral(sz,N)
p = isprime(spiral(sz));
[py, px] = find(p);
 
ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end