function obj = plate47_obj(row, col, N, sg)
% disorder_px(angle, scale_a2, scale_div, pts, line, num_pts, N)
obj = zeros([N N]);
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x, x);

r_circle = 5;
obj_funct = @() draw_circle(xx, yy, r_circle, sg);
num_sites = 40;
if(row == 1 && col == 1)
num_vacancies = 10;
strain_range = 2;
A = 1/3;
elseif(row == 1 && col == 2)
num_vacancies = 20;
strain_range = 2;
A = 1/3;
elseif(row == 1 && col == 3)
num_vacancies = 30;
strain_range = 2;
A = 1/3;
elseif(row == 2 && col == 1)
num_vacancies = 20;
strain_range = 2;
A = 1/5;
elseif(row == 2 && col == 2)
num_vacancies = 20;
strain_range = 2;
A = 2/5;
elseif(row == 2 && col == 3)
num_vacancies = 20;
strain_range = 2;
A = 4/5;
elseif(row == 3 && col == 1)
num_vacancies = 15;
strain_range = 3;
A = 1/3;
elseif(row == 3 && col == 2)
num_vacancies = 20;
strain_range = 3;
A = 1/2;
elseif(row == 3 && col == 3)
num_vacancies = 25;
strain_range = 3;
A = 4/5;
elseif(row == 4 && col == 1)
num_vacancies = 2;
strain_range = 5;
A = 4/5;
elseif(row == 4 && col == 2)
num_vacancies = 1;
strain_range = 6;
num_sites = 20;
A = 4/5;
elseif(row == 4 && col == 3)
num_vacancies = 1;
strain_range = 7;
num_sites = 20;
A = 4/5;
end

[px,py] = strain_coords(num_vacancies,num_sites, strain_range, A);
ratio = N/(max(py)-min(py));
px = px .* ratio;
py = py .* ratio;
px = px - (max(px)+min(px))/2;
py = py - (max(py)+min(py))/2;
for i = 1:size(px, 1)
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
end
end