arr_sz = 50;
x_val = -arr_sz:arr_sz-1;
[xx1, yy1] = meshgrid(x_val, y_val);
p = isprime(xx1.^2 + yy1.^2);
[py, px] = find(p);
ratio = N/arr_sz;
px = px .* ratio;
py = py .* ratio;

% x_val  = -arr_sz:arr_sz - 1;
% px = [];
% py = [];
% count = 1;
% for i = 1:size(x_val, 2)
%     for j = 1:size(x_val, 2)
% %         mag = sqrt(x(i)^2+x(j)^2)
%         if(x_val(i) == 0 || x_val(j) == 0)
%             if((mod(x_val(j), 4) == 3 && isprime(abs(x_val(j)))) || (mod(x_val(i), 4) == 3 && isprime(abs(x_val(i)))))
%                 px(count) = x_val(i);
%                 py(count) = x_val(j);
%                 count = count + 1;
%             end
%         else
%             if(mod(x_val(i)^2+x_val(j)^2, 4) == 1 && isprime(x_val(i)^2+x_val(j)^2))
%                 px(count) = x_val(i);
%                 py(count) = x_val(j);
%                 count = count + 1;
%             end
%         end
%     end
% end
% 
% ratio = N/arr_sz;
% px = px .* ratio;
% py = py .* ratio;