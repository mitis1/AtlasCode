function [px, py] = pinwheel(gen, x, theta, phi)
    prev_pt = [x, theta, phi];
    for i = 1:gen
        next_pts = [];
        for p = 1:size(prev_pt, 1)
            for tri = 1:5
                [x, theta, phi] = gen_pt(tri, prev_pt(p, :));
                next_pts = [next_pts; x, theta, phi];
            end
        end
        prev_pt = next_pts;
    end
    vertices = [];
    for i = 1:size(prev_pt, 1)
        [v1, v2, v3] = get_pts(prev_pt(i, :));
        vertices = [vertices, v1, v2, v3];
    end
    mag = abs(vertices);
    ang = angle(vertices);
    px = mag .* cos(ang);
    py = mag .* sin(ang);
end