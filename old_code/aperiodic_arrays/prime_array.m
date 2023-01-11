% num = 32;
% p = primes(num^2);
% [py, px] = ind2sub([num num], p);
% 
% ratio = N/(max(px)-min(px));
% px = px .* ratio;
% py = py .* ratio;
% py = py - N/2 - min(px) - ratio/2;
% px = px - N/2 - min(px) - ratio/2;


num = 32;
p = isprime(0:num^2-1);
p = reshape(p, [num,num]);
[py, px] = find(p);

% 
px = px .* ratio;
py = py .* ratio;
py = py - N/2 - min(px) - ratio/2;
px = px - N/2 - min(px) - ratio/2;