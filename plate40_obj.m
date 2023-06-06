function obj = plate40_obj(row, col, N, sg)
x = -N/2:N/2-1;
[xx, yy] = meshgrid(x,x);
r = 7;
obj_funct = @() draw_circle(xx, yy, r, sg);
gen1 = 6;
gen2 = 4;
start1 = 1;
start2 = [1,0;0,1];
sz = 36;
sz2 = 24;
scat_const = 1;
if(row == 1 && col == 1)
%     fib_array(gen,start, scat_const)
    [px, py]  = fib_array(gen1+1, 0, scat_const, N);
elseif(row == 1 && col == 2)
%     function [px,py] = gaussian_prime(N, arr_sz)
    [px, py] = gaussian_prime(N, sz2);
elseif(row == 1 && col == 3)
%     function [px,py] = coprime_array(arr_sz,N)
    [px, py] = coprime_array(sz2+6, N);
elseif(row == 2 && col == 1)
%     function [px,py] = penrose2(N,gen)
    [px, py] = penrose2(N, gen2);
elseif(row == 2 && col == 2)
%     function [px,py] = prime_array(num,N)
    [px, py] = prime_array(sz, N);
elseif(row == 2 && col == 3)
%     function [px,py] = rudin_shapiro(gen,start, scat_const)
    [px, py] = rudin_shapiro(gen1-1, start1, scat_const, N);
elseif(row == 3 && col == 1)
%     function [px,py] = thue_morse(start,gen, N)
    [px, py] = thue_morse(start2, gen2, N);
elseif(row == 3 && col == 2)
%     function [px,py] = ulam_spiral(sz,N)
    [px, py] = ulam_spiral(sz, N);
elseif(row == 3 && col == 3)
    num = 500;
    theta_init = pi*(3-sqrt(5));
    i = 1:num;
    t = theta_init*i; 
    r = sqrt(i/num);
    px = r.*cos(t); 
    py = r.*sin(t);
    
    ratio = N/max(max(px)-min(px), max(py)-min(py));
    px = px .* ratio;
    py = py .* ratio;
    px = px - (max(px)+min(px))/2;
    py = py - (max(py)+min(py))/2;
    px = px';
    py = py';
elseif(row == 4 && col == 1)
    % danzer array
    [px, py] = danzer_arr(N);
elseif(row == 4 && col == 2)
    % galois array
    [px, py] = galois_arr(N, sz);
elseif(row == 4 && col == 3)
    % pinwheel array
    [px, py] = pinwheel_arr(gen1, N);
end
obj = zeros(size(xx));
for i = 1:size(px,1)
%     if((row == 4 && col == 1) ...
%             && (round(px(i)+N/2) <= N && round(px(i)+N/2) > 0) ...
%             && (round(py(i)+N/2) <= N && round(py(i)+N/2) > 0) ...
%             && obj(round(px(i)+N/2), round(py(i)+N/2)) ~= 0)
%         continue;
%     end
    obj = obj + imtranslate(obj_funct(), [px(i), py(i)], 'bilinear');
end
obj(obj>4) = obj(obj>4)/5;
obj(obj>3) = obj(obj>3)/4;
obj(obj>2) = obj(obj>2)/3;
obj(obj>1) = obj(obj>1)/2;
end