function im = draw_lq(xx, yy, w, h, sg)
im = draw_rectangle(xx, yy, w, h, sg);
obj = draw_circle(xx, yy, w/2, sg);
im_yy = erfc( ((-yy)/2)/sg ) / 2 ;
obj = obj .* im_yy;
obj = imtranslate(obj, [0, h/2], 'bilinear');
im = im + obj;
obj = draw_circle(xx, yy, w/2, sg);
im_yy = erfc( ((yy)/2)/sg ) / 2 ;
obj = obj .* im_yy;
obj = imtranslate(obj, [0, -h/2], 'bilinear');
im = obj + im;
end