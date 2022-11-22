function im = draw_Ngon(xx, yy, N, sz, sg) 

    rr = sqrt( xx.^2 + yy.^2 );
    im = ones(size(xx));
    for ind = 0:(N-1)

        yy_rot = imrotate( yy, ind/N * 360, 'bilinear','crop');
        im_yy = erfc( ((yy_rot)-sz/2)/sg ) / 2 ;
        im = im.*im_yy;
    end

    im( rr> sz ) = 0;
end