function cmap = amp_colormap(N,start, stop)
    l_vals = linspace(0, 100, N);
    r = linspace(0, 20, (stop-start)/2);
    r = [r, flip(r)];
    % 20, 40, 60, 80
    theta = ones([1 (stop-start)]);
    theta = theta .* (pi/2);
    [x, y] = pol2cart(theta, r);
    start_mat = zeros([1 start]);
    end_mat = zeros([1 (N-stop)]);
    cmap = [l_vals; start_mat, x, end_mat; ...
                    start_mat, y, end_mat];
    cmap = cmap';
    cmap = lab2rgb(cmap, 'ColorSpace', 'adobe-rgb-1998');
    cmap(:, 1) = normalize(cmap(:, 1), 'range');
    cmap(:, 2) = normalize(cmap(:, 2), 'range');
    cmap(:, 3) = normalize(cmap(:, 3), 'range');
end