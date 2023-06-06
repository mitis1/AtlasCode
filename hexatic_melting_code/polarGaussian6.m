function g6 = polarGaussian6( x, xdata )
    t0  = x(2);
    A   = x(5);
    
    g6 = zeros(size(xdata(:,:,1)));
    
    for ind = -3:3
        x(2) = t0 + (ind*pi/3);
        g6 = g6 + polarGaussian( x, xdata );
    end
    
    g6 = (A*g6);
    
    
end

function g = polarGaussian( x, xdata )

    r0 = x(1);
    t0 = x(2);
    sg_r = x(3);
    sg_t = x(4)*sg_r/r0;
    
    g = exp( ...
            -0.5*(abs(xdata(:,:,1)-r0)/sg_r).^2 ...
            -0.5*(abs(xdata(:,:,2)-t0)/sg_t).^2 ...
           );
end
