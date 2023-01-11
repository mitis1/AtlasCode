function obj = draw_crystal(xx, yy, sz, spacing, r_circle, theta, phi, sg)
circle_funct = @( ) draw_circle(xx, yy, r_circle, sg);

px = -(spacing*(sz-1))/2:spacing:(spacing*(sz-1))/2;
py = px;
z = zeros(size(px));

R_phi = [1, 0, 0 ; 
             0, cosd(phi), sind(phi);
             0, -sind(phi), cosd(phi)];
R_theta = [cosd(theta), 0, sind(theta);
            0, 1, 0
            sind(theta), 0, cosd(theta)];
pts = R_theta * (R_phi * [px; py; z]);
px = pts(1,:);
py = pts(2,:);

obj = zeros(size(xx));
for i = 1:size(px,2)
    for j = 1:size(py,2)
    obj = obj + imtranslate(circle_funct(), [px(i), py(j)], 'bilinear');
    end
end
end