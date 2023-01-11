function [px, py] = galois_arr(N, sz)
col1 = [1;0;0;0];
for i = 5:sz
    next_val = col1(i-4) + col1(i-3);
    col1 = [col1; mod(next_val,2)];
end

mat = col1;
for i = 2:sz
    if(col1(i) == 1)
        mat = [mat, col1];
    else
        col_add = (-1*col1)+1;
        mat = [mat, col_add];
    end
end

[py, px] = find(mat);
px = px-(max(px)+min(px))/2;
py = py-(max(py)+min(py))/2;

ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end