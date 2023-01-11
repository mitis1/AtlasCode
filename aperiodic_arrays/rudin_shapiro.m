function [px,py] = rudin_shapiro(gen,start, scat_const, N)
% fibanocci
coords = convert_2D_array_to_coordinates(convert_1D_binary_to_2D_array(generate_1D_rudinShapiro_array(gen,start)'),scat_const);

px = coords(:,1);
py = coords(:,2);

ratio = N/(max(px)-min(px));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
end