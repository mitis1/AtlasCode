function im = draw_circle(xx, yy, r, sg) 
% Draw a soft edged circle centered at origin
    rr = sqrt( xx.^2 + yy.^2 );
    %im = -( erf(rr-r)/sg) -1) / 2;
    im = erfc( (rr-r)/sg ) / 2 ;

end