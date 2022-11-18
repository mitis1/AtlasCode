function im = soft_circle(xx, yy, r, sg) 

    im = -(erf((sqrt((xx).^2+(yy).^2)-r)/sg)-1)/2;

end