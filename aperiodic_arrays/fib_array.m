function [px,py] = fib_array(gen,start, scat_const, N)
% fibanocci
coords = convert_2D_array_to_coordinates(convert_1D_binary_to_2D_array(generate_1D_fibonacci_array(gen,start)'),scat_const);

px = coords(:,1);
py = coords(:,2);

ratio = N/(max(px) - min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (N/2+min(px));
py = py - (N/2+min(py));
end