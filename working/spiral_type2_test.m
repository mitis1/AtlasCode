
num_points = 149;

thetas = linspace( 0, 8*pi, num_points);
radius = linspace( 20, 35, num_points);
radius = (thetas.^0.75) *(15/(8*pi)) + 15;

xs = radius.*cos(thetas);
ys = radius.*sin(thetas);

figure

scatter(xs,ys, 20, 'k','filled')
axis equal