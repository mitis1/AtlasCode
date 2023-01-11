function obj = draw_hex(xx, yy, r_hex, r_circle, theta, phi, sg)
circle_funct = @( ) draw_circle(xx, yy, r_circle, sg);
R_phi = [1, 0, 0 ; 
             0, cosd(phi), sind(phi);
             0, -sind(phi), cosd(phi)];
R_theta = [cosd(theta), 0, sind(theta);
            0, 1, 0
            sind(theta), 0, cosd(theta)];


 px = r_hex*cosd( (0:60:300) + 30 );
 py = r_hex*sind( (0:60:300) + 30 );
 z = zeros(size(px));

 pts = R_theta * (R_phi * [px; py; z]);
 px = pts(1,:);
 py = pts(2,:);

 obj = zeros(size(xx));
 for i = 1:size(px,2)
     obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
 end
end