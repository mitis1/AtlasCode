function cmap = periodic_map(n,rep)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
c1 = [0, 1, 0];
c2 = [0, 0, 1];
n_inc = n/rep;
cmap = [];
for i = 1:rep
    if (mod(i, 2) == 0)
        cmap1 = [linspace(c1(1),c2(1),n_inc)' ,...
        linspace(c1(2),c2(2),n_inc)',...
        linspace(c1(3),c2(3),n_inc)'];
        cmap = [cmap ; cmap1];
    else
        cmap1 = [linspace(c2(1),c1(1),n_inc)' ,...
        linspace(c2(2),c1(2),n_inc)',...
        linspace(c2(3),c1(3),n_inc)'];
        if(i == 1)
            cmap = cmap1;
        else
            cmap = [cmap ; cmap1];
        end
    end
end

end