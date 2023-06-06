function [px,py] = strain_coords(num_vacancies,num_sites, strain_range, A)
lat_vec1 = [4.5, 0];
lat_vec2 = [0, 3.5];

% okay so basically your splitting up an index and coordinate values to
% make it easier to access, so you have index and coordinate values for
% each -> vacancies, original lattice, strained coordinates

% this is making those coordinate and index vectors/matricies
% making the coordinate vector
x = 1:num_sites;
[xx, yy] = meshgrid(x,x);

xx = reshape(xx, [size(xx, 1)*size(xx,2), 1]);
yy = reshape(yy, [size(yy, 1)*size(yy,2), 1]);

coords = [xx.*lat_vec1(1), yy.*lat_vec2(2)];
num_atoms = size(coords, 1);

% making the vacancies vector
% num_vacancies = (num_atoms * percent_vacancies)*2;

vacancy_ind = randi(num_atoms-20, num_vacancies,1)+20;
vacancy_coords = [coords(vacancy_ind, 1), coords(vacancy_ind,2)];
coords(vacancy_ind,:) = [];
% make empty vector for strained coordinates due to vacancies
strained_coords = [];
strained_ind = [];

% finding the location of strained vectors and shifting them
% deal with one vacancy at a time
for i = 1:num_vacancies
    vac = vacancy_coords(i, :);
    % distance of each coordinate from the vacancies
    x_dist = vac(1) - coords(:,1);
    y_dist = vac(2) - coords(:,2);
    total_dist = sqrt(x_dist.^2 + y_dist.^2);

    % finding the coordinates that are affected by that vacancy
    % see if the distance to the vacancy is less than 3x the spacing
    % between atoms
    vec_lim = min(lat_vec1(1), lat_vec2(2));
    nearest_neighbor_ind = find(total_dist < vec_lim * strain_range);
    new_cords = zeros(size(nearest_neighbor_ind));
    ind = 1;

    % 3D Gaussian for estimating displacement - maybe reread this code
    x_lim = min(coords(nearest_neighbor_ind,1)):0.001:max(coords(nearest_neighbor_ind,1));
    y_lim = min(coords(nearest_neighbor_ind,2)):0.001:max(coords(nearest_neighbor_ind,2));

    [x_nn, y_nn] = meshgrid(x_lim, y_lim);

    gauss_mat = A * exp(-( (x_nn-vac(1)).^2 ./ (2*lat_vec1(1)^2) + (y_nn-vac(2)).^2 ./ (2*lat_vec2(2)^2) ));
    for nn_idx = 1:size(nearest_neighbor_ind,1)
        nn_ind = nearest_neighbor_ind(nn_idx);
        x_change_ind = find(x_lim == coords(nn_ind,1));
        y_change_ind = find(y_lim == coords(nn_ind,2));
        scale_val = gauss_mat(y_change_ind, x_change_ind);
%         new_cords = [];
        new_cords(ind, 1) = coords(nn_ind,1) + x_dist(nn_ind)*scale_val;
        new_cords(ind, 2) = coords(nn_ind,2) + y_dist(nn_ind)*scale_val;

        ind = ind + 1;
        if(~ismember(nn_ind, strained_ind))
            strained_coords = [strained_coords; new_cords(ind-1,:)];
            strained_ind = [strained_ind; nn_ind];
        end
    end
end

coords(strained_ind,:) = strained_coords;
px = coords(:,1);
py = coords(:,2);

end