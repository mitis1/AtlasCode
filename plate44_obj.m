function obj = plate44_obj(row, col, N, sg)
xs = linspace(-50*pi, 50*pi, N);
[xx,yy] = meshgrid( xs,xs );
% rr = sqrt( xx.^2 + yy.^2 );
pp = atan2(yy,xx);
pp2 = atan2(-yy-50, xx+50);
y = sin( xx/5 + 1*pp + 0*pp2);
y = (y + 1)/2;
y = y.* draw_circle(xx, yy, 50*pi, 10);

if(row == 1 && col == 1)
    xs = linspace(-50*pi, 50*pi, N);
    [xx,yy] = meshgrid( xs,xs );
    y = sin( xx/5 );
    y = (y + 1)/2;
    obj = y.* draw_circle(xx, yy, 50*pi, 10);
    return
elseif(row == 1 && col == 2)
    xs = linspace(-50*pi, 50*pi, N);
    [xx,yy] = meshgrid( xs,xs );
    y = cos( xx/5 );
    y = (y + 1)/2;
    obj = y.* draw_circle(xx, yy, 50*pi, 10);
    return
elseif(row == 1 && col == 3)
    mult = [1/2,1,0,0];
    scale = [1,0,0];
    offset = [0,0,0];
    scalex = [1,0,0];
    offsetx = [0,0,0];


elseif(row == 2 && col == 1)
    mult = [1/2,2,0,0];
    scale = [1,0,0];
    offset = [0,0,0];
    scalex = [1,0,0];
    offsetx = [0,0,0];
elseif(row == 2 && col == 2)    
    mult = [1,5,0,0];
    scale = [1,0,0];
    offset = [0,0,0];
    scalex = [1,0,0];
    offsetx = [0,0,0];
elseif(row == 2 && col == 3)
    mult = [1,5,0,0];
    scale = [1,0,0];
    offset = [50,0,0];
    scalex = [1,0,0];
    offsetx = [-50,0,0];


elseif(row == 3 && col == 1)
    mult = [1/2,1,1,0];
    scale = [1,1,0];
    offset = [50,0,0];
    scalex = [1,1,0];
    offsetx = [0,0,0];
elseif(row == 3 && col == 2)
    mult = [1/2,1,1,0];
    scale = [1,-1,0];
    offset = [50,0,0];
    scalex = [1,1,0];
    offsetx = [0,0,0];
elseif(row == 3 && col == 3)
    mult = [1/2,5,1,0];
    scale = [1,-1,0];
    offset = [50,0,0];
    scalex = [1,1,0];
    offsetx = [0,0,0];


elseif(row == 4 && col == 1)
    mult = [1/2,1,1,1];
    scale = [1,-1,1];
    offset = [-50,0,50];
    scalex = [1,1,1];
    offsetx = [0,0,0];
elseif(row == 4 && col == 2)
    mult = [1/2,5,1,5];
    scale = [-1,-1,1];
    offset = [0,0,0];
    scalex = [1,1,1];
    offsetx = [-50,0,50];
elseif(row == 4 && col == 3)
    mult = [1/2,1,1,1];
    scale = [1,-1,1];
    offset = [-50,0,50];
    scalex = [1,1,1];
    offsetx = [-75,0,75];
end

pp = atan2(scale(1)*yy+offset(1),scalex(1)*xx+offsetx(1));
pp2 = atan2(scale(2)*yy+offset(2),scalex(2)*xx+offsetx(2));
pp3 = atan2(scale(3)*yy+offset(3),scalex(3)*xx+offsetx(3));
y = sin( mult(1)*xx + mult(2)*pp + mult(3)*pp2 + mult(4)*pp3);
obj = (y + 1)/2;
end