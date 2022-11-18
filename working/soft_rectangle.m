function im = soft_rectangle(xx, yy, w, h, sg) 

    im = (-(erf( (abs(xx)-w/2)/sg) -1)/2) .* (-(erf( (abs(yy)-h/2)/sg) -1)/2);

end