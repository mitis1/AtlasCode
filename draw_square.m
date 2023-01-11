function obj = draw_square(xx, yy, spacing, r_circle, sg)
circle_funct = @( ) draw_circle(xx, yy, r_circle, sg);

 px = [-spacing/2, spacing/2, -spacing/2, spacing/2];
 py = [-spacing/2, -spacing/2, spacing/2, spacing/2];

 obj = zeros(size(xx));
 for i = 1:size(px,2)
     obj = obj + imtranslate(circle_funct(), [px(i), py(i)], 'bilinear');
 end

end