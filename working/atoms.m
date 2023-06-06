N = 32;
x = -N/2:N/2-1;
[xx,yy] = meshgrid(x,x);
numAtoms = 2;
spacing = 3;
r = 4;
sg = 2;
xp = [(r+spacing) - 0.5, -(r+spacing) + 0.5];
yp = zeros(size(xp)); zp = yp;
[px, py] = meshgrid(xp, yp);

totalVolume = zeros(size(xx));
    for j = 1:size(px,2)
        for i = 1:size(px,1)
%             randy = rand(1,1)*spacing/4 - spacing/8;
%             randx = rand(1,1)*spacing/4 - spacing/8;
%             randz = rand(1,1)*spacing/4 - spacing/8;

            randy = 0;
            randx = 0;
            randz = 0;
            rr = sqrt((xx-px(i,j)+randx).^2 + (yy-py(i,j)+randy).^2);
            im = erfc( (rr-r)/sg ) / 2 ;
            totalVolume = totalVolume + im;
        end
    end
