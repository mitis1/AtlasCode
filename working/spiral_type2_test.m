
num_points = 300;

thetas = linspace( 0, 8*pi, num_points);
radius = linspace( 20, 35, num_points);

xs = radius.*cos(thetas);
ys = radius.*sin(thetas);

figure

scatter(xs,ys, 20, 'k','filled')
axis equal