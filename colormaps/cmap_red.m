function cmap = cmap_red(n, start, stop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c1 = [0, 0, 0];
c2 = [226, 110, 110]/255;
c3 = [1, 1, 1];
gray_scale = [linspace(c1(1),c3(1),n)' ,...
    linspace(c1(2),c3(2),n)',...
    linspace(c1(3),c3(3),n)'];
gray_start = gray_scale(start, :);
gray_end = gray_scale(stop, :);

cmap1 = [linspace(gray_start(1),c2(1),(stop-start)/2)' ,...
    linspace(gray_start(2),c2(2),(stop-start)/2)',...
    linspace(gray_start(3),c2(3),(stop-start)/2)'];

cmap2 = [linspace(c2(1),gray_end(1),(stop-start)/2)', ...
    linspace(c2(2),gray_end(2),(stop-start)/2)', ...
    linspace(c2(3),gray_end(3),(stop-start)/2)'];
cmap = [gray_scale(1:start, :); cmap1 ; cmap2; gray_scale(stop:end, :)];
end