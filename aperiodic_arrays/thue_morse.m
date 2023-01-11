function [px,py] = thue_morse(start,gen, N)
for i = 1:gen
    inv = (-1*start) + 1;
    next = [inv, start; start, inv];
    start = next;
%     figure(1)
%     imagesc(start)
end
[py,px] = find(start);
ratio = N/max(max(px)-min(px), max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end