function im = draw_rectangle(xx, yy, w, h, sg) 

    im_x = erfc( (abs(xx)-w/2)/sg ) / 2 ;
    im_y = erfc( (abs(yy)-h/2)/sg ) / 2 ;

    im = im_x.*im_y;
end