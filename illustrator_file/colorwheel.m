x = -126 : 126;
[xx, yy] = meshgrid(x, x);
[theta, rr] = cart2pol(xx, yy);
theta = theta + (pi/2);
L = 80 .* ones(size(xx));
a = L .* cos(theta);
b = L .* sin(theta);

a(rr > 126) = 0;
b(rr > 126) = 0;
L(rr > 126) = 100;

pha_rgb = lab2rgb( cat(3, L, a, b));
pha_rgb( pha_rgb>1 ) = 1;
pha_rgb( pha_rgb<0 ) = 0;


combined = figure;
hold on;
set(gca, 'YDir', 'reverse')
imagesc(pha_rgb);
axis square;
axis tight;
axis off;
% pa = polaraxes;
% set(pa, 'color', 'none');
% set(pa, 'color', 'none');
% set(pa, 'fontsize', 25);
% pa.RTickLabel = [];
exportgraphics(gcf,"colorwheel.tif");
hold off;