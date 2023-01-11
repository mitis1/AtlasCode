function [px,py] = penrose1(N,gen)
t = aTriangle(0,cosd(0) + 1i*sin(0), []);
for k = 1:gen
    t = decomposeTriangles(t);
%     k
end
% showTriangles(t);
px = [real(t.Apex); real(t.Left); real(t.Right)];
py = [imag(t.Apex); imag(t.Left); imag(t.Right)];

ratio = (N*1.5)/min(max(px) - min(px), max(py) - min(py));
px = px * ratio;
py = py * ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end