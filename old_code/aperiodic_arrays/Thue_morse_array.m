start = [1, 0; 0, 1];
next = start;
gen = 4;

for i = 1:gen
    inv = (-1*start) + 1;
    next = [inv, start; start, inv];
    start = next;
%     figure(1)
%     imagesc(start)
end
ratio = N/size(start,1);
[py,px] = find(start);
px = px .* ratio;
py = py .* ratio;
px = px - N/2;
py = py - N/2;