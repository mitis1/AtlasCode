function result = shiftx(mat,num)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
x_size = size(mat, 2);
if(num < 0)
    result = zeros(size(mat));
    result(:, 1:x_size+num) = mat(:, (-1*num)+1:end);
else
    result = zeros(size(mat));
    result(:, num+1:end) = mat(:, 1:x_size-num);
end
end