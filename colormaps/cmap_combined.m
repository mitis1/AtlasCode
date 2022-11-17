function cmap = cmap_combined(n,rep)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
black = [0, 0, 0];
blue = [0, 0, 1];
white = [1, 1, 1];
green = [0, 1, 0];
mid = (n)/2;
blue1 = [linspace(black(1),blue(1),mid)' ,...
    linspace(black(2),blue(2),mid)',...
    linspace(black(3),blue(3),mid)'];

blue2 = [linspace(blue(1),white(1),mid)', ...
    linspace(blue(2),white(2),mid)', ...
    linspace(blue(3),white(3),mid)'];
blue_map = [blue1 ; blue2];

green1 = [linspace(black(1),green(1),mid)' ,...
    linspace(black(2),green(2),mid)',...
    linspace(black(3),green(3),mid)'];

green2 = [linspace(green(1),white(1),mid)', ...
    linspace(green(2),white(2),mid)', ...
    linspace(green(3),white(3),mid)'];
green_map = [green1 ; green2];

n_inc = n/rep;
cmap = [];
for i = 1:rep
    if (mod(i, 2) == 0)
        cmap1 = [linspace(green_map(n_inc*(i-1), 1), blue_map(n_inc*i, 1),n_inc)' ,...
                linspace(green_map(n_inc*(i-1), 2), blue_map(n_inc*i, 2),n_inc)',...
                linspace(green_map(n_inc*(i-1), 3), blue_map(n_inc*i, 3),n_inc)'];
        cmap = [cmap ; cmap1];
    else
        if(i == 1)
            cmap1 = [linspace(blue_map(1, 1), green_map(n_inc*i, 1),n_inc)' ,...
                linspace(blue_map(1, 2), green_map(n_inc*i, 2),n_inc)',...
                linspace(blue_map(1, 3), green_map(n_inc*i, 3),n_inc)'];
            cmap = cmap1;
        else
            cmap1 = [linspace(blue_map(n_inc*(i-1), 1), green_map(n_inc*i, 1),n_inc)' ,...
                linspace(blue_map(n_inc*(i-1), 2), green_map(n_inc*i, 2),n_inc)',...
                linspace(blue_map(n_inc*(i-1), 3), green_map(n_inc*i, 3),n_inc)'];
            cmap = [cmap ; cmap1];
        end
    end
end
end