
ring_radii = 20:5:40;
num_rings = length(ring_radii);

num_points = 20;
theta_offset = pi/25;

figure
hold on
for ind_ring = 1:num_rings
    thetas = linspace(0,2*pi, num_points+1);
    thetas(end) = [];
    thetas = thetas + ind_ring*theta_offset;
    xs = ring_radii(ind_ring)*cos(thetas);
    ys = ring_radii(ind_ring)*sin(thetas);

    scatter(xs,ys, 5, 'k','filled')
end

axis equal