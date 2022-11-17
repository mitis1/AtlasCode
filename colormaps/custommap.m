function map = custommap(N)

    l = linspace(30,100,N)';
    th = linspace(-pi/2, 0,N)';

    amp = 1;%(1-cos( (1:N)/N*2*pi ))'/2;

    a = 80*amp.*cos(th);
    b = 80*amp.*sin(th);

    figure
    scatter3(a,b,l)
    xlim([-1 1]*85)
    ylim([-1 1]*85)

    map = lab2rgb([l a b]);
    
    map( map>1) = 1;
    map( map<0 ) = 0;
end