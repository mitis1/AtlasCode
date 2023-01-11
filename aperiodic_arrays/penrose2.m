function [px,py] = penrose2(N,gen)
t = table;
for k = 1:5
    thetad = 72*(k-1);
    t_a = aTriangle(0,cosd(thetad) + 1i*sind(thetad),[]);
    t_ap = apTriangle(0,t_a.Right,[]);
    t = [t ; t_a ; t_ap];
end
t2 = t;
for k = 1:gen
    t2 = decomposeTriangles(t2);
end
t = t2;
px = [real(t.Apex); real(t.Left); real(t.Right)];
py = [imag(t.Apex); imag(t.Left); imag(t.Right)];

ratio = N/(max(px)-min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end