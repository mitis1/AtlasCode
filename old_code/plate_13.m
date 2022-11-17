r_width = 5;
r_height = 10;
box_width = 21;
box_height = 21;
angle = 30;

r = tilted_rect(r_width, r_height, box_width, box_height, angle);
figure(1)
imagesc(r)

[row, cols] = find_circle_centers(5, 8, 11, 11);

mat = zeros(size(11, 11));  
for i=1:length(row)
    mat(row(i), cols(i)) = 1;
end

figure(2)
imagesc(mat)