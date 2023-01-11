%% Vogel spiral
num = 1000;
theta_init = pi*(3-sqrt(5));
i = 1:num;
t = theta_init*i; 
r = sqrt(i/num);
x = r.*cos(t); 
y = r.*sin(t);
figure(1)
scatter(x, y, 'filled');

%% plate 10, row 4, col 1
x = -N/2:spacing:N/2;
    [px, py] = meshgrid(x, x);
    err = 0.1 * spacing;
    for i = 1:size(px, 2)
        px(:, i) = px(:,i) - err + (err*2)*rand(size(px, 1), 1);
    end
